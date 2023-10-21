package com.itbank.handler;

import com.itbank.model.Role;
import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.model.UserRole;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.repository.UserRepository;
import com.itbank.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Map;
import java.util.UUID;

@Component
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
            OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();

//            반환되는 데이터 출력
            Map<String, Object> attributes = oauth2User.getAttributes();
            for (Map.Entry<String, Object> entry : attributes.entrySet()) {
                System.out.println(entry.getKey() + ": " + entry.getValue());
            }

            // 구글만 있다고 가정
            String provider = "google";
            // 서비스마다 파라미터 이름 다름
            String providerId = oauth2User.getAttribute("sub");

            System.out.println("provider: " + provider);

            SocialLogin socialLogin = socialLoginRepository.findByProviderId(providerId).orElseGet(() -> {

                System.out.println("소셜유저 생성");
                
                // USER 권한 찾기 또는 생성
                Role role = roleRepository.findByName("ROLE_USER").orElseGet(() -> {
                    Role newRole = new Role();
                    newRole.setName("ROLE_USER");
                    return roleRepository.save(newRole);
                });

                // User 객체 생성
                User user = new User();
                user.setUsername(oauth2User.getName());
                user.setPassword(passwordEncoder.encode(UUID.randomUUID().toString())); // 소셜로그인 유저는 비밀번호가 없음 -> UUID를 해싱처리해서 일반유저로 로그인 X
                user.setMobile("010-0000-0000");  // 구글은 폰번호 없어서 주석처리
//                user.setMobile(oauth2User.getAttribute("mobile"));  // 구글은 폰번호 없어서 주석처리
                user.setName(oauth2User.getAttribute("name"));
                user.setEmail(oauth2User.getAttribute("email"));
                user.setLoginAt(null);
                user.setLogoutAt(null);
                user.setCreatedAt(new Date(System.currentTimeMillis()));
                user.setBirth(new Date(System.currentTimeMillis()));
                user.setRemainTime(new Date(System.currentTimeMillis()));
                user = userRepository.save(user);

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
                newSocialUser.setUpdateAt(null);

                return socialLoginRepository.save(newSocialUser);
            });

            System.out.println("redirect: /");
            response.sendRedirect("/");
        }
    }
}
