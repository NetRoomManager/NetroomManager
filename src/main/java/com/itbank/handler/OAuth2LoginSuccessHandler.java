package com.itbank.handler;

import com.itbank.config.UserPrincipal;
import com.itbank.model.RemainingTime;
import com.itbank.model.User;
import com.itbank.model.UserLog;
import com.itbank.repository.jpa.RemainingTimeRepository;
import com.itbank.repository.jpa.UserLogRepository;
import com.itbank.repository.jpa.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class OAuth2LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {


    @Autowired
    private UserLogRepository userLogRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RemainingTimeRepository remainingTimeRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {


        RequestCache requestCache = new HttpSessionRequestCache();
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        String targetUrl = "/customer/seat";
        if (savedRequest != null) {
            targetUrl = savedRequest.getRedirectUrl();
        }

        if (authentication.getPrincipal() instanceof UserPrincipal) {
            UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
            String username = userPrincipal.getUsername();

            Optional<User> optionalUser = userRepository.findByUsername(username);

            if(optionalUser.isPresent()) {

                User user = optionalUser.get();



                log.info("남은 시간을 불러오는중");
                RemainingTime remainingTime = remainingTimeRepository.findById(user.getId()).orElseGet(() -> {
                    RemainingTime newRemainingTime = new RemainingTime();
                    newRemainingTime.setUser(user);
                    newRemainingTime.setRemainingTime(15);
                    user.setRemainingTime(newRemainingTime);

                    // 업데이트
                    userRepository.save(user);

                    return newRemainingTime;
                });

                if(remainingTime.getRemainingTime() <= 0) {
                    // 남은 시간이 없다면 세션 날림
                    request.getSession().invalidate();

                    // 이용권 충전 페이지로 보냄
                    targetUrl = "/auth/buyTicket";

                }
            }
        }


        response.sendRedirect("/auth/loginSuccess?targetUrl=" + URLEncoder.encode(targetUrl, "UTF-8"));
    }
}