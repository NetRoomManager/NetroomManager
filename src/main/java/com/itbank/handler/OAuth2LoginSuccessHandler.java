package com.itbank.handler;

import com.itbank.model.Role;
import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.model.UserRole;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.repository.UserRepository;
import com.itbank.repository.UserRoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.ProviderException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.UUID;

@Component
@Slf4j
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private SocialLoginRepository socialLoginRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        System.out.println("성공 핸들러");
        
        if (authentication.getPrincipal() instanceof OAuth2User) {

            // 인증된 유저의 상세정보가 담겨있음 / 서비스 이름, 유저 상세정보가 담겨있음
            OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
            OAuth2User oauth2User = oauthToken.getPrincipal();


            // attributes에 유저 상세정보를 출력함
            Map<String, Object> attributes = oauth2User.getAttributes();

            // ~~~~~~~~~~~~~~테스트용~~~~~~~~~~~~~~~~
            // 불러온 유저 정보를 콘솔에 출력함
            for (Map.Entry<String, Object> entry : attributes.entrySet()) {
                System.out.println(entry.getKey() + ": " + entry.getValue());
            }

            // 서비스 이름
            String provider = oauthToken.getAuthorizedClientRegistrationId();

            // 고유번호
            String providerId;
            if("naver".equals(provider)){
                // 네이버는 고유번호 key가 id
                providerId = oauth2User.getAttribute("id");
            }
            else if("google".equals(provider)){
                // 구글 고유번호 key : sub
                providerId = oauth2User.getAttribute("sub");
            }
         /*   else if("kakao".equals(provider)){
                // 카카오 고유번호 key :
            }*/
            else {
                providerId = null;
                throw new ProviderException("알 수 없는 서비스 입니다");
            }

            // 고유번호를 DB에서 조회함 / 없다면 생성함
            socialLoginRepository.findByProviderId(providerId).orElseGet(() -> {

                String username = providerId;
                String password = passwordEncoder.encode(UUID.randomUUID().toString());
                String mobile = oauth2User.getAttribute("mobile");
                String name = oauth2User.getAttribute("name");
                String email = oauth2User.getAttribute("email");
                // 네이버는 year, day 분리해서 반환해줌
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                String strBirth = oauth2User.getAttribute("birthyear") + "-" + oauth2User.getAttribute("birthday");
                Date birth = null;
                try {
                    java.util.Date utilDate = format.parse(strBirth);
                    birth = new java.sql.Date(utilDate.getTime());
                } catch (Exception e) {
                    e.printStackTrace();
                }

                log.info("소셜유저 생성");

                // USER 권한 찾기 또는 생성 / 기본으로 USER권한을 설정함
                Role role = roleRepository.findByName("ROLE_USER").orElseGet(() -> {
                    Role newRole = new Role();
                    newRole.setName("ROLE_USER");
                    return roleRepository.save(newRole);
                });

                // User 객체 생성 or 불러오기 / 만약 불러와진다면 해당 계정은 소셜유저와 연동됨
                Date finalBirth = birth;
                User user = userRepository.findByEmailOrMobile(email, mobile).orElseGet(() -> {
                    User newUser = new User();
                    newUser.setUsername(username);
                    newUser.setPassword(password); // 소셜로그인 유저는 비밀번호가 없음 -> UUID를 해싱처리해서 일반유저로 로그인 X
                    newUser.setMobile(mobile);  // 구글은 폰번호 없어서 주석처리
//                user.setMobile(oauth2User.getAttribute("mobile"));  // 구글은 폰번호 없어서 주석처리
                    newUser.setName(name);
                    newUser.setEmail(email);
                    newUser.setBirth(finalBirth);
                    return userRepository.save(newUser);
                });

                if(user.getDropOutUser() != null){
                    throw new UsernameNotFoundException("탈퇴된 유저입니다.");
                }

                // User와 Role 정보가 담긴 객체 생성
                UserRole userRole = new UserRole();
                userRole.setRole(role);
                userRole.setUser(user);
                userRoleRepository.save(userRole);

                SocialLogin newSocialUser = new SocialLogin();
                newSocialUser.setUser(user);
                newSocialUser.setProvider(provider);
                newSocialUser.setProviderId(providerId);
                newSocialUser.setCreateAt(new Date(System.currentTimeMillis()));

                return socialLoginRepository.save(newSocialUser);
            });

            response.sendRedirect("/auth/loginSuccess");
        }
    }
}
