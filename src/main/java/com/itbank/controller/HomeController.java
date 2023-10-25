package com.itbank.controller;

import com.itbank.model.SocialLogin;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Optional;

@Controller
@Slf4j
public class HomeController {

	@Autowired private UserService userService;

	@Autowired private SocialLoginRepository socialLoginRepository;

	@GetMapping({"/home", "/"})
	public String home() {
		log.info("home");
		return "home";
	}
}
