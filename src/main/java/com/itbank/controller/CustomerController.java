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
        // 유저랑 좌석연결
        // 임시로 좌석상태가 사용가능인곳 자동 배정
    }

    @GetMapping("/order")
    public void order() {}

    @GetMapping("/recharge")
    public void recharge() {}
}
