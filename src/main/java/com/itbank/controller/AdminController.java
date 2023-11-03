package com.itbank.controller;

import com.itbank.model.Product;
import com.itbank.model.Ticket;
import com.itbank.service.ProductService;
import com.itbank.service.TicketService;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private TicketService ticketService;

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
    public ModelAndView ticket() {
        ModelAndView mav = new ModelAndView("/admin/ticket_manage");
        List<Ticket> ticketList = ticketService.selectTicketList();
        mav.addObject("ticketList", ticketList);
        return mav;
    }

    @PostMapping("/ticketRegister")
    public String addTicket(Ticket ticket){
        if(ticket.getId() == null){
            log.info("이용권 추가 form");
            int i = ticketService.addTicket(ticket);
            log.info(i +"개의 이용권이 추가되었습니다");
        }
        else {
            log.info(ticket.getId() + "번 이용권 변경");
            int i = ticketService.updateTicket(ticket);
            log.info(i + "개의 이용권이 변경되었습니다 :  이용권 번호 [" + ticket.getId() + "]");
        }
        return "redirect:/admin/ticket";
    }

    @GetMapping("/deleteTicket/{ticketId}")
    public String deleteTicket(@PathVariable int ticketId){
        log.info(ticketId + "번 이용권 삭제");
        int i = ticketService.deleteTicket(ticketId);
        log.info(i + "개의 이용권을 삭제하였습니다");
        return "redirect:/admin/ticket";
    }



    // 상품 매출
    @GetMapping("/productsales")
    public String productSale() {
        return "/admin/product_sales_manage";
    }
    
    // 이용권 매출
    @GetMapping("/ticketsales")
    public String ticketSale() {
        return"/admin/ticket_sales_manage";
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
