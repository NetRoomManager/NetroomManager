package com.itbank.controller;

import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.repository.SocialLoginRepository;
import com.itbank.repository.UserRepository;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@Slf4j
public class HomeController {

	@Autowired private UserService userService;

	@Autowired private SocialLoginRepository socialLoginRepository;

	@Autowired private UserRepository userRepository;

	@GetMapping({"/home", "/"})
	public String home(HttpSession session){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName(); // get logged in username
		Optional<User> optionalUser = userRepository.findByUsername(username);
		Optional<SocialLogin> socialLogin = socialLoginRepository.findByProviderId(username);
		if (optionalUser.isPresent()){
			User login = optionalUser.get();
			session.setAttribute("login", login);
		}
		if(socialLogin.isPresent()){
			Optional<User> optionalLogin = userRepository.findBySocialLogins(socialLogin.get());
			if(optionalLogin.isPresent()){
				User login = optionalLogin.get();
				session.setAttribute("login", login);
			}
		}
		return "home";
	}
}
