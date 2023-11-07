package com.itbank.config;


import com.itbank.model.User;
import com.itbank.service.UserLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Collections;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 일반유저랑 소셜유저 묶는 클래스
 * User는 직접 구현한 Entity임
 */

public class UserPrincipal implements OAuth2User, UserDetails {
    private final User user;
    private final Map<String, Object> attributes;

    public UserPrincipal(User user) {
        this.user = user;
        this.attributes = null;
    }

    public UserPrincipal(User user, Map<String, Object> attributes) {
        this.user = user;
        this.attributes = attributes;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getUsername();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return user.getUserRoles().stream().map(role -> new SimpleGrantedAuthority(role.getRole().getName())).collect(Collectors.toList());
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    public String getEmail() {
        return user.getEmail();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes != null ? Collections.unmodifiableMap(attributes) : Collections.emptyMap();
    }

    @Override
    public String getName() {
        return user.getName();
    }

    public User getUser() {
        return user;
    }

    @Override
    public String toString() {
        return "UserPrincipal{" +
                "username='" + user.getUsername() + '\'' +
                ", name='" + user.getName() + '\'' +
                ", authorities=" + getAuthorities() +
                '}';
    }
}
