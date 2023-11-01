package com.itbank.service;

import com.itbank.model.*;
import com.itbank.repository.RoleRepository;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.repository.UserRepository;
import com.itbank.repository.UserRoleRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.parameters.P;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Date;
import java.util.*;

@Service
@Slf4j
// 일반 유저 생성, 삭제, 조회 등이 이루어 지는 클래스
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private UserLogService userLogService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public void createAdmin(User paramUser) {

        log.info("관리자를 생성합니다");

        try {
            // USER 권한 찾기 또는 생성
            Role role = roleRepository.findByName("ROLE_ADMIN").orElseGet(() -> {
                Role newRole = new Role();
                newRole.setName("ROLE_ADMIN");
                return roleRepository.save(newRole);
            });

            // User 객체 생성
            userRepository.save(paramUser);

            // User와 Role 정보가 담긴 객체 생성
                UserRole userRole = new UserRole();
            userRole.setRole(role);
            userRole.setUser(paramUser);
            userRoleRepository.save(userRole);

        }
        // 중복 가입 처리
        catch (DataIntegrityViolationException e) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "이미 가입된 정보입니다",  e);
        }
    }

    public void createUsers(User paramUser) {

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
            user.setUsername(paramUser.getUsername());
            user.setPassword(passwordEncoder.encode(paramUser.getPassword()));
            user.setMobile(paramUser.getMobile());
            user.setName(paramUser.getName());
            user.setEmail(paramUser.getEmail());
            user.setBirth(paramUser.getBirth());
            userRepository.save(user);

            // User와 Role 정보가 담긴 객체 생성
            UserRole userRole = new UserRole();
            userRole.setRole(role);
            userRole.setUser(user);
            userRoleRepository.save(userRole);

        }
        // 중복 가입 처리
        catch (DataIntegrityViolationException e) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "이미 가입된 정보입니다",  e);
        }
    }

    public void testAdmin() {

        System.out.println("유저를 생성합니다...");

        // USER 권한 찾기 또는 생성
        Role role = roleRepository.findByName("ROLE_ADMIN").orElseGet(() -> {
            Role newRole = new Role();
            newRole.setName("ROLE_ADMIN");
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


    public List<UserAndLastLog> findUserAndLastLog() {
        log.info("검색어 X");
        return findUserAndLastLog("", null);
    }
    public List<UserAndLastLog> findUserAndLastLog(String type, String keyword) {

        log.info("유형: " + type);
        log.info("검색어: "+keyword);

        List<UserAndLastLog> list = new ArrayList<>();
        List<User> users = null;

        switch (type) {
            // 전체검색
            case "" :
                users = userRepository.findAllByKeyword(keyword==null ? "" : keyword);
                break;
            case "name":
                users = userRepository.findAllByNameContaining(keyword);
                break;
            case "username":
                users = userRepository.findAllByUsernameContaining(keyword);
                break;
            case "mobile":
                users = userRepository.findAllByMobileContaining(keyword);
                break;
            case "email":
                users = userRepository.findAllByEmailContaining(keyword);
                break;
            default:
                users = userRepository.findAll();
                break;
        }

        for(User user : users) {
            UserAndLastLog userAndLastLog = new UserAndLastLog();
            userAndLastLog.setUser(user);
            Optional<UserLog> optionalUserLog = userLogService.findLatestByUser(user);
            if(optionalUserLog.isPresent()) {
                UserLog log = optionalUserLog.get();
                userAndLastLog.setLastLog(log);
            }
            list.add(userAndLastLog);
        }
        return list;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }


    public Optional<User> checkId(String username) {
        return userRepository.findByUsername(username);
    }
}
