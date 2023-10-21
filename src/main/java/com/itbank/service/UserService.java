package com.itbank.service;

import com.itbank.model.Role;
import com.itbank.model.User;
import com.itbank.model.UserRole;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.UserRepository;
import com.itbank.repository.UserRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void createUsers() {

        System.out.println("유저를 생성합니다...");

        // USER 권한 찾기 또는 생성
        Role role = roleRepository.findByName("ROLE_USER");

        if(role == null){
            role = new Role();
            role.setName("ROLE_USER");
            // Role 정보 먼저 저장
            roleRepository.save(role);
        }

        // User 객체 생성
        User user = new User();
        user.setUsername("username");
        user.setPassword(passwordEncoder.encode("password"));
        user.setMobile("mobileNumber");
        user.setName("name");
        user.setEmail("email@example.com");
        user.setLoginAt(new Date(System.currentTimeMillis()));
        user.setLogoutAt(new Date(System.currentTimeMillis()));
        user.setCreatedAt(new Date(System.currentTimeMillis()));
        user.setBirth(new Date(System.currentTimeMillis()));
        user.setRemainTime(new Date(System.currentTimeMillis()));
        userRepository.save(user);

        // User와 Role 정보가 담긴 객체 생성
        UserRole userRole = new UserRole();
        userRole.setRole(role);
        userRole.setUser(user);
        userRoleRepository.save(userRole);

    }
}
