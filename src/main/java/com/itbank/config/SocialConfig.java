package com.itbank.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class SocialConfig {
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
        // 카카오
        registrations.add(ClientRegistration.withRegistrationId("kakao")
                .clientId("a051bc66b61e4ddcc2d1df8142573cdd")
//                .clientSecret("RC9zsO3ahACbZ7b17ChJFB3VNStFtjrC")
                .tokenUri("https://kauth.kakao.com/oauth/token")
                .authorizationUri("https://kauth.kakao.com/oauth/authorize")
                .redirectUri("http://localhost:8080/login/oauth2/code/kakao")
                .userInfoUri("https://kapi.kakao.com/v2/user/me")
                .userNameAttributeName("kakao_account")
//                .jwkSetUri("")
                .clientName("Kakao")
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .scope("account_email")
                .build());

        return new InMemoryClientRegistrationRepository(registrations);
    }
}
