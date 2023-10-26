package com.itbank.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itbank.config.UserPrincipal;
import com.itbank.model.DropOutUser;
import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.repository.DropOutUserRepository;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

@Service
@Slf4j
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SocialLoginRepository socialLoginRepository;

    @Autowired
    private DropOutUserRepository dropOutUserRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    // 소셜유저 로그인, 회원가입 시 정보를 불러오는 메서드
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2user = delegate.loadUser(userRequest);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        if ("naver".equals(registrationId)) {

            // response로 감싸진 정보를 가져옴
            oAuth2user = processNaverOauth(oAuth2user);

            // 탈퇴회원 조회하기 위해 가져옴 / username1234 형식
            String providerId = registrationId + "_" + (String)oAuth2user.getAttributes().get("id");

            // 탈퇴 검증 로직
            Optional<SocialLogin> socialLoginOptional = socialLoginRepository.findByProviderAndProviderId(registrationId, providerId);

            if(socialLoginOptional.isPresent()){
                SocialLogin socialLogin= socialLoginOptional.get();
                User user=socialLogin.getUser();

                Optional<DropOutUser> dropOutUserOptional=dropOutUserRepository.findById(user.getId());

                if(dropOutUserOptional.isPresent()){
                    throw new AuthenticationServiceException("탈퇴된 계정입니다");
                }

            }

            // 탈퇴 회원 아 아니라면 -> 로그인 or 회원가입
            return oAuth2user;
        }
        return oAuth2user;
    }

    // 네이버는 response로 한번 더 감싸져있음 ㅅㅂ
    private OAuth2User processNaverOauth(OAuth2User oAuth2User){
        Map<String,Object> attributes = (Map<String,Object>)oAuth2User.getAttributes().get("response");
        log.info("네이버 정보를 불러옵니다." + attributes);
        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),attributes,"id");
    }

}

