package com.itbank.controller;

import com.itbank.model.Product;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy._Proxy_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Objects;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    // 상품관리
    @GetMapping("/product")
    public String product() {
//        productService.createProduct();
        return "/admin/product_manage";
    }

    // 좌석관리
    @GetMapping("/seat")
    public String seat() {
        return "/admin/seat_manage";
    }

    // 매출관리
    @GetMapping("/sales")
    public String sales() {
        return "/admin/sales_manage";
    }

    // 이용권관리
    @GetMapping("/ticket")
    public String ticket() {
        return "/admin/ticket_manage";
    }

    // 회원관리

    @GetMapping("/user")
    public ModelAndView user(String type, String keyword) {
        log.info("유형: " + type);
        log.info("검색어: "+keyword);
        ModelAndView mav = new ModelAndView("/admin/user_manage");
        if( type==null && keyword==null){
            mav.addObject("list", userService.findUserAndLastLog());
        }
        else {
            mav.addObject("list",userService.findUserAndLastLog(Objects.requireNonNull(type), keyword));
        }
        return mav;
    }



    // 주문관리
    @GetMapping("/order")
    public String order() {
        return "/admin/order_manage";
    }
}
