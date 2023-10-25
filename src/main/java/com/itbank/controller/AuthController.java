package com.itbank.controller;

import com.itbank.model.PaymentResponse;
import com.itbank.model.User;
import com.itbank.service.PaymentService;
import com.itbank.service.UserDetailsServiceImpl;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private PaymentService paymentService;

    @RequestMapping("/login")
    public void login() {
    }

    @PostMapping("/join")
    public String join(User user, HttpServletRequest request) {

        log.info("유저 생성");

        userService.createUsers(user);

        log.info("유저 생성 완료!!");

        // 사용자의 이름과 권한을 가져와서 Authentication 객체를 만듭니다.
        UserDetails userDetails = userDetailsService.loadUserByUsername(user.getUsername());
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

        // 만든 Authentication 객체를 SecurityContext에 설정합니다.
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // 세션에 SPRING_SECURITY_CONTEXT라는 키 값으로 SecurityContext를 저장합니다.
        HttpSession session = request.getSession(true);
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());

        return "redirect:/";
    }

    @GetMapping("/loginSuccess")
    public void loginSuccess() {
    }

    @GetMapping("/buyTicket")
    public void buyTicket() {}

    @PostMapping("/buyTicket")
    @ResponseBody
    public String buyTicket(@RequestBody PaymentResponse paymentResponse) throws IllegalAccessException {

        if (paymentResponse.isSuccess()) {
            paymentService.buyTicket(paymentResponse);
        } else {
            throw new IllegalAccessException("결제 실패");
        }
        return "success";
    }
}
