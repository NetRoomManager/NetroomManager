package com.itbank.controller;

import com.itbank.repository.jpa.SocialLoginRepository;
import com.itbank.repository.mybatis.TestDAO;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@Slf4j
public class HomeController {

	@Autowired private UserService userService;

	@Autowired private SocialLoginRepository socialLoginRepository;

	@Autowired private TestDAO testDAO;

	@GetMapping({"/home", "/"})
	public String home(Model model) {
		model.addAttribute("version", testDAO.getVersion());
		log.info("home");
		return "redirect:/customer/main";
	}

	@RequestMapping("/error")
	public String handle404() {
		System.out.println("ㅈ버그 발견");
		// 에러 페이지로 이동
		return "/auth/error";
	}
}
