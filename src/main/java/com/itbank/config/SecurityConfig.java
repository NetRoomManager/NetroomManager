package com.itbank.config;

import com.itbank.handler.OAuth2LoginSuccessHandler;
import com.itbank.service.CustomOAuth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Configuration
@EnableWebSecurity(debug = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/","/test","/aaa").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/user/**").hasAnyRole("USER", "ADMIN")
                .anyRequest().authenticated()
                .and().formLogin()
                .and().oauth2Login()
                .successHandler(oAuth2LoginSuccessHandler)
                .userInfoEndpoint()
                .userService(customOAuth2UserService);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
        // 여기서 passwordEncoder를 사용하여 비밀번호를 인코딩합니다. 스프링 시큐리티에서 제공하는 BCryptPasswordEncoder를 사용하였습니다.
    }



    @Bean
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
                        .scope("openid", "profile", "email")
                // Scopes are the permissions that are being requested from the user for his/her profile information.
                // For example, if you want to show users' profile pictures, then you need to request a 'profile' scope.
                // If you want to access users' email addresses and basic profile info (first name, last name),
                // then request an 'email' scope.
                // If your application needs access to other parts of the user's account or data (like Google Drive or Calendar),
                // then request those scopes as well.
                //
                // Note: The exact way scopes are requested and how they're used depends on the provider.
                //
                //
                //.userInfoAuthenticationMethod(AuthenticationMethod.HEADER)
//                .userNameAttributeName(StandardClaimNames.SUB)
                .build()
        );

        return new InMemoryClientRegistrationRepository(registrations);
    }

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


}