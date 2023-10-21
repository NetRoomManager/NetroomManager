package com.itbank.service;

import com.itbank.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.stream.Collectors;

@Service
@Slf4j
public class UserDetailsServiceImpl implements UserDetailsService {



    @Autowired
    private UserRepository userRepository;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        System.out.println(username + "님의 정보를 불러옵니다");

        com.itbank.model.User customUser= userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + "님의 정보를 찾을 수 없습니다"));

        return new User(customUser.getUsername(), customUser.getPassword(), getAuthorities(customUser));
    }

    private static Collection<? extends GrantedAuthority> getAuthorities(com.itbank.model.User customUser) {
        System.out.println(customUser.getUsername() + "님의 권한을 불러옵니다");
        return customUser.getUserRoles().stream().map(role -> new SimpleGrantedAuthority(role.getRole().getName())).collect(Collectors.toList());
    }
}

