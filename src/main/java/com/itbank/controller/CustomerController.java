package com.itbank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @GetMapping("/chat")
    public void chat() {
    }

    @GetMapping("/main")
    public void main() {
    }

    @GetMapping("/order")
    public void order() {}

    @GetMapping("/recharge")
    public void recharge() {}
}
