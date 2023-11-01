package com.itbank.controller;


import com.itbank.model.Seat;
import com.itbank.service.ProductService;
import com.itbank.service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductService productService;
    @Autowired
    private SeatService seatService;

    @GetMapping("/product")
    public String product() {
        productService.createProduct();
        return "redirect:/";
    }


    @GetMapping("/seat")
    public String seatTest(){
        seatService.createSeat();
        return "redirect:/";
    }


    @GetMapping("/seat_manage")
    public ModelAndView seat() {
        ModelAndView mav = new ModelAndView("/admin/seat_manage");

        List<Seat> seatList = seatService.selectSeatList();
        mav.addObject("seatList",seatList);
        return mav;
    }

}
