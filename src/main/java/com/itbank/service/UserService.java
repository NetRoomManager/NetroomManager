package com.itbank.service;

import com.itbank.model.Role;
import com.itbank.model.User;
import com.itbank.model.UserRole;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.UserRepository;
import com.itbank.repository.UserRoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Date;
import java.util.Optional;

@Service
@Slf4j
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

        log.info("유저를 생성합니다");

        try {

            // USER 권한 찾기 또는 생성
            Role role = roleRepository.findByName("ROLE_USER").orElseGet(() -> {
                Role newRole = new Role();
                newRole.setName("ROLE_USER");
                return roleRepository.save(newRole);
            });

            // User 객체 생성
            User user = new User();
            user.setUsername("username");
            user.setPassword(passwordEncoder.encode("password"));
            user.setMobile("mobileNumber");
            user.setName("name");
            user.setEmail("email@example.com");
            user.setBirth(new Date(System.currentTimeMillis()));
            userRepository.save(user);

            // User와 Role 정보가 담긴 객체 생성
            UserRole userRole = new UserRole();
            userRole.setRole(role);
            userRole.setUser(user);
            userRoleRepository.save(userRole);
        }
        // 중복 가입 처
        catch (DataIntegrityViolationException e) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "이미 가입된 정보입니다",  e);
        }
    }
}
