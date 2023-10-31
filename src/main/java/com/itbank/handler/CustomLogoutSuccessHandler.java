package com.itbank.handler;

import com.itbank.config.UserPrincipal;
import com.itbank.model.UserLog;
import com.itbank.service.UserLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        log.info("세션 종료됨");

        // 세션이 종료될 때의 동작을 정의
        if (authentication != null && authentication.getPrincipal() instanceof UserPrincipal) {
            UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();

            Pageable pageable = PageRequest.of(0, 1, Sort.Direction.DESC, "id");
            Page<UserLog> userLogs = userLogService.findLatestByUser(userPrincipal.getUser(), pageable);
            Optional<UserLog> userLog = userLogs.getContent().stream().findFirst();

            if (userLog.isPresent()) {
                UserLog log = userLog.get();
                log.setLogoutAt(new Date(System.currentTimeMillis())); // 로그아웃 시간을 현재 시간으로 설정
                userLogService.save(log); // UserLog를 데이터베이스에 저장
            }
        }

        // 로그아웃 이후에는 홈으로 보냄
        response.sendRedirect("/");
    }
}
