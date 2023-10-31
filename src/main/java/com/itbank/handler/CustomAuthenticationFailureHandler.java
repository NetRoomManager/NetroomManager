package com.itbank.handler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@Slf4j
// 일반 로그인, 회원가입할때 실패 시 들어오는 핸들러
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception)
            throws IOException, ServletException {

;        log.info("로그인 실패");
        request.setAttribute("errorMessage", "Invalid username or password.");
        // 포워드해주거나 리다이렉트
        response.sendRedirect("/auth/login");
    }
}
