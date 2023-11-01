package com.itbank.service;

import com.itbank.config.UserPrincipal;
import com.itbank.model.User;
import com.itbank.model.UserLog;
import com.itbank.repository.jpa.UserLogRepository;
import com.itbank.repository.jpa.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@Slf4j
// UserDetailsService는 시큐리티에서 관리하는 User를 제어하는 클래스
// 이를 구현해서 User Entity를 제어하기 위해 만든 클래스
public class UserDetailsServiceImpl implements UserDetailsService {



    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserLogRepository userLogRepository;



    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        System.out.println(username + "님의 정보를 불러옵니다");

        User customUser= userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + "님의 정보를 찾을 수 없습니다"));

        if (customUser.getDropOutUser() != null) {
            throw new AuthenticationServiceException("탈퇴된 계정입니다");
        }

        // 유저 로그 추가
        createUserLog(customUser);

        return new UserPrincipal(customUser);
    }

    private void createUserLog(User user) {
        UserLog log = new UserLog();
        log.setUser(user);
        userLogRepository.save(log);
    }
}

