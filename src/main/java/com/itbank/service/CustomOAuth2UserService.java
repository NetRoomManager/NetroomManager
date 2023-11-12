package com.itbank.service;

import com.itbank.config.UserPrincipal;
import com.itbank.model.*;
import com.itbank.repository.jpa.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.security.ProviderException;
import java.sql.Date;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SocialLoginRepository socialLoginRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RemainingTimeRepository remainingTimeRepository;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;


    @Override
    // 소셜유저 로그인, 회원가입 시 정보를 불러오는 메서드
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        System.out.println("떠라 ㅅㅂ");

        log.info("소셜유저를 불러옵니다");

        DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2user = delegate.loadUser(userRequest);

        // 소셜 서비스 이름 ex)naver
        String provider = userRequest.getClientRegistration().getRegistrationId();

        log.info("서비스: " + provider);

        if("naver".equals(provider)) {
            oAuth2user = processNaverOauth(oAuth2user);
        }

        // 일반유저와 통합관리하기위해 연동된 유저를 반환함
        return new UserPrincipal(findOrCreate(oAuth2user, provider));
    }

    // 네이버는 response로 한번 더 감싸져있음 ㅅㅂ
    private OAuth2User processNaverOauth(OAuth2User oAuth2User){
        Map<String,Object> attributes = (Map<String,Object>)oAuth2User.getAttributes().get("response");
        log.info("네이버 정보를 불러옵니다." + attributes);
        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),attributes,"id");
    }

    private User findOrCreate(OAuth2User oauth2User, String provider) {

        // attributes에 유저 상세정보를 출력함
        Map<String, Object> attributes = oauth2User.getAttributes();

        // ~~~~~~~~~~~~~~테스트용~~~~~~~~~~~~~~~~
        // 불러온 유저 정보를 콘솔에 출력함
        for (Map.Entry<String, Object> entry : attributes.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // 소셜 고유 아이디 불러오기
        String providerId = getProviderId(oauth2User, provider);

        SocialLogin socialLogin = socialLoginRepository.findByProviderId(providerId).orElseGet(() -> {

            // 고유아이디
            // 비밀번호 UUID넣기
            String password = passwordEncoder.encode(UUID.randomUUID().toString());
            // 폰번호
//            String mobile = oauth2User.getAttribute("mobile");
            String mobile;
            if(oauth2User.getAttribute("mobile")!=null) {
                mobile = oauth2User.getAttribute("mobile");
            } else {
                mobile = null;
            }
            // 생일
//            Date birth = oauth2User.getAttribute("birth");
            Date birth;
            if (oauth2User.getAttribute("birth")!=null) {
                birth = oauth2User.getAttribute("birth");
            } else {
                birth = null;
            }
            // 이름
            String name = oauth2User.getAttribute("name");
            // 이메일
            String email = oauth2User.getAttribute("email");

            log.info("소셜유저 생성...");

            // USER 권한 찾기 또는 생성 / 기본으로 USER권한을 설정함
            Role role = roleRepository.findByName("ROLE_USER").orElseGet(() -> {
                Role newRole = new Role();
                newRole.setName("ROLE_USER");
                return roleRepository.save(newRole);
            });

            // User 객체 생성 or 불러오기 / 만약 불러와진다면 해당 계정은 소셜유저와 연동됨
            User user = userRepository.findByEmailAndEmailIsNotNullOrMobileAndMobileIsNotNull(email, mobile).orElseGet(() -> {
                User newUser = new User();
                newUser.setUsername(providerId);
                newUser.setPassword(password); // 소셜로그인 유저는 비밀번호가 없음 -> UUID를 해싱처리해서 일반유저로 로그인 X
                newUser.setMobile(mobile);
                newUser.setName(name);
                newUser.setEmail(email);
                newUser.setBirth(birth);
                return userRepository.save(newUser);
            });

            // 탈퇴유저 검증
            if(user.getDropOutUser() != null){
                throw new UsernameNotFoundException("탈퇴된 유저입니다.");
            }

            // User와 Role 정보가 담긴 객체 생성
            UserRole userRole = userRoleRepository.findByUser(user).orElseGet(() -> {
                UserRole newUserRole = new UserRole();
                newUserRole.setRole(role);
                newUserRole.setUser(user);
                return userRoleRepository.save(newUserRole);
            });

            // 유저권한 세팅
            user.setUserRoles(new HashSet<UserRole>());
            user.getUserRoles().add(userRole);

            SocialLogin newSocialUser = new SocialLogin();
            newSocialUser.setUser(user);
            newSocialUser.setProvider(provider);
            newSocialUser.setProviderId(providerId);

            return socialLoginRepository.save(newSocialUser);
        });

        return socialLogin.getUser();
    }

    private String getProviderId(OAuth2User oauth2User, String provider){
        String providerId = null;
        if("naver".equals(provider)){
            // 네이버는 고유번호 key가 id
            providerId = oauth2User.getAttribute("id");
        }
        else if("google".equals(provider)){
            // 구글 고유번호 key : sub
            providerId = oauth2User.getAttribute("sub");
        }
        else if("facebook".equals(provider)){
            providerId = oauth2User.getAttribute("id");
        }
        else {
            throw new ProviderException("알 수 없는 서비스 입니다");
        }
        return providerId;
    }

}

