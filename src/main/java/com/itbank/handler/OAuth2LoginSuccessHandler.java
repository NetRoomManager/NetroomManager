package com.itbank.handler;

import com.itbank.config.UserPrincipal;
import com.itbank.model.User;
import com.itbank.model.UserLog;
import com.itbank.repository.jpa.UserLogRepository;
import com.itbank.repository.jpa.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Optional;

@Component
@Slf4j
public class OAuth2LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {


    @Autowired
    private UserLogRepository userLogRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {


        if (authentication.getPrincipal() instanceof UserPrincipal) {
            UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
            String username = userPrincipal.getUsername();

            Optional<User> user = userRepository.findByUsername(username);

            if(user.isPresent()) {
                UserLog log = new UserLog();
                log.setUser(user.get());
                userLogRepository.save(log);
            }
        }

        RequestCache requestCache = new HttpSessionRequestCache();
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        String targetUrl = "/";
        if (savedRequest != null) {
            targetUrl = savedRequest.getRedirectUrl();
        }

        response.sendRedirect("/auth/loginSuccess?targetUrl=" + URLEncoder.encode(targetUrl, "UTF-8"));
    }
}