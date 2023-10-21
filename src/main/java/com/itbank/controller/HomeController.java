package com.itbank.controller;

import com.itbank.model.SocialLogin;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Optional;

@Controller
public class HomeController {

	@Autowired private UserService userService;

	@Autowired private SocialLoginRepository socialLoginRepository;

	@GetMapping("/home")
	public String home() {
		return "home";
	}
	
	@GetMapping("/test")
	public String test() {
		System.out.println("테스트");
		userService.createUsers();
		return "ㅎㅇ";
	}
	@GetMapping("/test2")
	public String test2() {
		Optional<SocialLogin> optionalSocialLogin = socialLoginRepository.findByProviderId("113139697013462458250");
		if(optionalSocialLogin.isPresent()) {
			System.out.println("성공");
			System.out.println(optionalSocialLogin.get().getProviderId());
		} else {
			System.out.println("실패");
		}
		return "/login";
	}

	@GetMapping("/success")
	public String success() {
		return "로그인 성공";
	}
	
}
