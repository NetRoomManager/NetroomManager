package com.itbank.controller;

import com.itbank.model.PaymentResponse;
import com.itbank.model.User;
import com.itbank.service.PaymentService;
import com.itbank.service.UserDetailsServiceImpl;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Slf4j
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/login")
    public void login() {
    }

    @PostMapping("/login")
    public String login(User user, HttpServletRequest request) {

        log.info("로그인중");
        System.out.println("로그인");
        // 사용자의 이름과 권한을 가져와서 Authentication 객체를 만듭니다.
        UserDetails userDetails = userDetailsService.loadUserByUsernameAndPassword(user.getUsername(), user.getPassword());
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

        // 만든 Authentication 객체를 SecurityContext에 설정합니다.
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // 세션에 SPRING_SECURITY_CONTEXT라는 키 값으로 SecurityContext를 저장합니다.
        HttpSession session = request.getSession(true);
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());

        return "redirect:/";
    }

    @GetMapping("/test")
    public String test() {
        userService.testAdmin();
        return "redirect:/auth/login";
    }

    @GetMapping("/create_admin")
    public String create_admin(HttpServletRequest request) {

        log.info("관리자 생성");
        User user = new User();
        user.setUsername("admin");
        user.setMobile("010-9999-9999");
        user.setPassword(passwordEncoder.encode("1234"));
        user.setName("admin");
        user.setEmail("admin@naver.com");
        user.setBirth(null);

        userService.createAdmin(user);

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
    public ModelAndView buyTicket() {
        ModelAndView mav = new ModelAndView("/auth/buyTicket");

        List<User> list = userService.findAll();

        mav.addObject("list", list);

        return mav;
    }

    @PostMapping("/buyTicket")
    @ResponseBody
    public Map<String, Boolean> buyTicket(@RequestBody PaymentResponse paymentResponse) throws UsernameNotFoundException {

        paymentService.buyTicket(paymentResponse);

        Map<String, Boolean> result = new HashMap<>();
        result.put("success", true);
        return result;
    }

    @PostMapping("/checkId")
    @ResponseBody
    public Map<String, Boolean> checkId(@RequestBody User user) {
        // 받은 유저 아이디로 검색해서 중복이면 true 아니면 false
        boolean duplicate = userService.checkId(user.getUsername()).isEmpty();
        Map<String, Boolean> result = new HashMap<>();
        result.put("duplicate", duplicate);
        return result;
    }

}
