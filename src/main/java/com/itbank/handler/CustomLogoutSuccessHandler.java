package com.itbank.handler;

import com.itbank.config.UserPrincipal;
import com.itbank.model.RemainingTime;
import com.itbank.model.UserLog;
import com.itbank.repository.jpa.RemainingTimeRepository;
import com.itbank.service.UserLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Optional;

@Component
@Slf4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    @Autowired
    private UserLogService userLogService;

    @Autowired
    private RemainingTimeRepository remainingTimeRepository;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        log.info("세션 종료됨");

        // 세션이 종료될 때의 동작을 정의
        if (authentication != null && authentication.getPrincipal() instanceof UserPrincipal) {
            UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();

            log.info("로그달기");


//            // 채팅 메시지 삭제
//            String chatKeyPattern1 = "chat:" + userPrincipal.getUsername() + ":*";
//            String chatKeyPattern2 = "chat:*:" + userPrincipal.getUsername();
//            Set<String> chatKeys1 = redisTemplate.keys(chatKeyPattern1);
//            Set<String> chatKeys2 = redisTemplate.keys(chatKeyPattern2);
//            if (chatKeys1 != null) {
//                redisTemplate.delete(chatKeys1);
//            }
//            if (chatKeys2 != null) {
//                redisTemplate.delete(chatKeys2);
//            }

            // 해당하는 유저의 최근 로그를 불러옴
            Optional<UserLog> userLog = userLogService.findLatestByUser(userPrincipal.getUser());

            if (userLog.isPresent()) {
                UserLog log = userLog.get();
                log.setLogoutAt(new Date(System.currentTimeMillis())); // 로그아웃 시간을 현재 시간으로 설정
                userLogService.save(log); // UserLog를 데이터베이스에 저장
            }

            log.info("로그저장 성공");

            log.info(userPrincipal.getUsername() + "의 남은 시간을 불러옵니다");

            // 레디스에서 남은 시간 불러옴

            String key = userPrincipal.getUsername() + " " + remainingTimeRepository.findByUser(userPrincipal.getUser()).get().getRemainingTime();

            log.info("key: " + key);
            log.info("value: " + redisTemplate.opsForValue().get(key));

            Object value = redisTemplate.opsForValue().get(key);
            Long time = null;
            if (value instanceof Integer) {
                time = Long.valueOf((Integer) value);
            } else if (value instanceof Long) {
                time = (Long) value;
            }


            log.info("불러오기 성공! : " + time+"초");

            if(time==null) { // null이면 핸들러로 들어온거임 ?time=1초 이런식으로 들어옴
                time = Long.valueOf((String) request.getParameter("time"));
                log.info("파라미터로 받은 time: " + time);
            }


            // 유저의 DB남은시간 컬럼에
            Optional<RemainingTime> optionalRemainingTime = remainingTimeRepository.findById(userPrincipal.getUser().getId());
            if(optionalRemainingTime.isPresent()){
                RemainingTime remainingTime = optionalRemainingTime.get();
                log.info("로그인 이전 저장된 시간: " + remainingTime.getRemainingTime());

                // 로그인 시간과 로그아웃시간으로 사용시간 불러옴
                Long usingTimeInMs = userLog.get().getLogoutAt().getTime() - userLog.get().getLoginAt().getTime();
                Long usingTimeInSecounds = usingTimeInMs / 1000;
                log.info("사용 시간(초): " + usingTimeInSecounds);


                // 저장되어있던 시간에 사용시간을 빼줌
                Integer newRemainingTime = remainingTime.getRemainingTime() - usingTimeInSecounds.intValue();
                log.info("저장할 시간(초): " + newRemainingTime);
                if(newRemainingTime<0) { // 만약 음수가 들어오면 0으로 변경
                    newRemainingTime=0;
                }
                remainingTime.setRemainingTime(newRemainingTime);

                remainingTimeRepository.save(remainingTime);
            }
            log.info("남은시간 저장 완료!");

        }

        // 로그아웃 이후에는 홈으로 보냄
        response.sendRedirect("/");
    }
}
