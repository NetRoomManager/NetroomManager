package com.itbank.service;

import com.itbank.config.UserPrincipal;
import com.itbank.model.User;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuthUser = super.loadUser(userRequest);

        // 원격 서비스(예: Google, Facebook 등)로부터 받은 사용자 정보
        Map<String, Object> attributes = oAuthUser.getAttributes();

        // 소셜 or 일반 유저를 User객체에 저장해서 불러옴
        User user = findOrCreate(attributes);

        return UserPrincipal.create(user, attributes);
    }

    private User findOrCreate(Map<String, Object> attributes) {

        return null;
    }

}

