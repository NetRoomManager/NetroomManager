package com.itbank.controller;

import com.itbank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@Autowired private UserService userService;

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

	@GetMapping("/success")
	public String success() {
		return "로그인 성공";
	}
	
}
