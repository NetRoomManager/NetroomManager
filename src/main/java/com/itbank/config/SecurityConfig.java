package com.itbank.config;

import com.itbank.handler.CustomLogoutSuccessHandler;
import com.itbank.handler.OAuth2LoginSuccessHandler;
import com.itbank.service.CustomOAuth2UserService;
import com.itbank.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebSecurity(debug = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CustomLogoutSuccessHandler customLogoutSuccessHandler;

    // 스프링 시큐리티 설정
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        // 최대 세션의 개수를 1개로 설정
        http
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            .sessionFixation().migrateSession()
            .maximumSessions(1).maxSessionsPreventsLogin(true);
        // 웹소켓 메시지를 위한 설정
        http.cors().and().  // CORS 허용
                csrf().disable()
                .headers().frameOptions().sameOrigin();

        http.authorizeRequests()
                .antMatchers("/", "/auth/**", "/img/**", "/css/**", "/js/**", "/audio/**")
                // 위 경로는 로그인 안해도 ㄱㄴ
                .permitAll()

                .antMatchers("/admin/**")
//                // ADMIN만 가능
                .hasRole("ADMIN")
//
                .antMatchers("/customer/**")
//                // ADMIN, USER가능
                .hasAnyRole("USER", "ADMIN")
                .anyRequest().authenticated()
                .and()

                .formLogin().disable()
                .logout().disable()

                .formLogin()
                // 로그인 페이지 지정
                .loginPage("/auth/login")
                .successHandler((request, response, exception) -> {
                    System.out.println("로그인 성공 핸들러");
                    response.sendRedirect("/customer/seat");
                })
                // 실패시 핸들러
                .failureHandler(((request, response, exception) -> {
                    if(exception instanceof AuthenticationServiceException) {
                        response.sendRedirect("/auth/buyTicket");
                    }
                    else {
                        response.sendRedirect("/auth/login?error");
                    }
                }))
                // 성공시 URL
//                .defaultSuccessUrl("/")
                // 로그인 처리 담당할 주소
                .loginProcessingUrl("/auth/login")
                .and()
                .logout()
                // 로그아웃 URL
                .logoutUrl("/auth/logout")
                // 로그아웃 성공 URL
//                .logoutSuccessUrl("/customer/main")
                // 로그아웃시 세션 날림
                .invalidateHttpSession(true)
                // 쿠키도 날림
                .deleteCookies("JSESSIONID")
                .logoutSuccessHandler(customLogoutSuccessHandler) // 로그아웃 성공 핸들러 설정
//                .failureUrl("/auth/login?error=true")
                // 소셜 활성화
                .and()
                .oauth2Login()
                // 성공 핸들러
                .successHandler(oAuth2LoginSuccessHandler)
                .userInfoEndpoint()
                // 서비스 클래스 지정
                .userService(customOAuth2UserService);
    }

    @Override
    // 유저 비밀번호 암호화
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }


    @Bean
    // 소셜 API 정보
    public ClientRegistrationRepository clientRegistrationRepository() {
        List<ClientRegistration> registrations = new ArrayList<>();
        // Google의 경우:
        registrations.add(ClientRegistration.withRegistrationId("google")
                .clientId("439669195010-hi0k3aip9pgqc2amkjdbre403c198asi.apps.googleusercontent.com")
                .clientSecret("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")
                .tokenUri("https://oauth2.googleapis.com/token")
                .authorizationUri("https://accounts.google.com/o/oauth2/auth")
                .redirectUri("http://localhost:8080/login/oauth2/code/google")
                .userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo")
                .userNameAttributeName(IdTokenClaimNames.SUB)
                .jwkSetUri("https://www.googleapis.com/oauth2/v3/certs")
                .clientName("Google")
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .scope("profile", "email")
                .build()
        );
        // 네이버
        registrations.add(ClientRegistration.withRegistrationId("naver")
                .clientId("WWwFXLwl3tyqfT06xnMN")
                .clientSecret("KLHosuYDrJ")
                .tokenUri("https://nid.naver.com/oauth2.0/token")
                .authorizationUri("https://nid.naver.com/oauth2.0/authorize")
                .redirectUri("http://localhost:8080/login/oauth2/code/naver")
                .userInfoUri("https://openapi.naver.com/v1/nid/me")
                .userNameAttributeName("response")
//                .jwkSetUri("")
                .clientName("Naver")
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .scope("profile", "email")
                .build());
        // 페이스북
        registrations.add(ClientRegistration.withRegistrationId("facebook")
                .clientId("1450673375539413")
                .clientSecret("6aa54388d4dae6c9e9494e65482e5103")
                .tokenUri("https://graph.facebook.com/v2.8/oauth/access_token")
                .authorizationUri("https://www.facebook.com/v2.8/dialog/oauth")
                .redirectUri("http://localhost:8080/login/oauth2/code/facebook")
                .userInfoUri("https://graph.facebook.com/me?fields=id,name,email")
                .userNameAttributeName("id")
                .clientName("Facebook")
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .scope("email", "public_profile")
                .build());

        return new InMemoryClientRegistrationRepository(registrations);
    }


    // 저장한 정보를 메모리에 저장
    @Bean
    public OAuth2AuthorizedClientService authorizedClientService(ClientRegistrationRepository clientRegistrationRepository) {
        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository);
    }

    @Bean
    public RestTemplate restTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
        return restTemplate;
    }

    // CORS 허용
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("*"));  // 모든 도메인에서의 요청 허용
        configuration.setAllowedMethods(Arrays.asList("GET","POST"));  // GET, POST 요청 허용
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

}