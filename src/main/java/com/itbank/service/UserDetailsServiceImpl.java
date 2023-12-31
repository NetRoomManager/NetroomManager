package com.itbank.service;

import com.itbank.config.UserPrincipal;
import com.itbank.model.RemainingTime;
import com.itbank.model.User;
import com.itbank.model.UserLog;
import com.itbank.model.dto.Summoner;
import com.itbank.repository.jpa.RemainingTimeRepository;
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

import java.util.Optional;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
// UserDetailsService는 시큐리티에서 관리하는 User를 제어하는 클래스
// 이를 구현해서 User Entity를 제어하기 위해 만든 클래스
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RemainingTimeRepository remainingTimeRepository;

    @Autowired
    private UserLogRepository userLogRepository;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private RiotAPIService riotAPIService;

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        System.out.println(username + "님의 정보를 불러옵니다");

        User customUser= userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username + "님의 정보를 찾을 수 없습니다"));

        String nick = customUser.getSummoner();
        Summoner summoner = riotAPIService.getSummoner(nick);
        customUser.setTire(summoner.getTier() + " " + summoner.getRank());
        userRepository.save(customUser);


        log.info(customUser.getUsername() + "티어: " + customUser.getTire());

        if (customUser.getDropOutUser() != null) {
            throw new UsernameNotFoundException("탈퇴된 계정입니다");
        }

        // 유저의 남은 시간을 불러옴
        RemainingTime remainingTime = remainingTimeRepository.findById(customUser.getId()).orElseGet(() -> {
            RemainingTime newRemainingTime = new RemainingTime();
            newRemainingTime.setUser(customUser);
            newRemainingTime.setRemainingTime(0);
            return remainingTimeRepository.save(newRemainingTime);
        });

        long remaningTime = remainingTime.getRemainingTime();

        if (remaningTime <= 0) {
            throw new AuthenticationServiceException("남은 시간이 없습니다. 티켓을 구매해주세요.");
        }

        log.info(username + "님의 남은 시간: " + remaningTime + "초");

        return new UserPrincipal(customUser);
    }
}

