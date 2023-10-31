package com.itbank.controller;

import com.itbank.model.Product;
import com.itbank.service.ProductService;
import com.itbank.service.TicketService;
import oracle.jdbc.proxy._Proxy_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private TicketService ticketService;

    @GetMapping("/product")
    public String product() {
//        productService.createProduct();
        return "/admin/product_manage";
    }


}
