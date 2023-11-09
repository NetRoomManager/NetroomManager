package com.itbank.controller;

import com.itbank.model.*;
import com.itbank.model.dto.SeatInfoDTO;
import com.itbank.repository.jpa.DropOutUserRepository;
import com.itbank.repository.jpa.ProductRepository;
import com.itbank.repository.mybatis.DropOutUserDAO;
import com.itbank.service.*;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
@Slf4j
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private TicketSalesService ticketSalesService;

    @Autowired
    private UserService userService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private SeatService seatService;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private DropOutUserRepository dropOutUserRepository;

    @Autowired
    private DropOutUserDAO dropOutUserDAO;

    // 상품관리
    @GetMapping("/product")
    public ModelAndView product() {
        ModelAndView mav = new ModelAndView("/admin/product_manage");
        List<ProductDTO> productList = productService.selectAllProduct();
        List<ProductCategory> productCategoryList = productService.selectAllProductCategory();
        mav.addObject("productList", productList);
        mav.addObject("productCategoryList", productCategoryList);
        mav.addObject("currentPage", "product");
        return mav;
    }

    @GetMapping("/userdelete/{id}")
    public String userDelete(@PathVariable("id") Long id) {

        log.info("id :" + id);
        // delete지만 insert여

        User user = userService.findById(id).orElseThrow(() -> new UsernameNotFoundException("없는 유저입니다"));

        DropOutUser dropOutUser = dropOutUserRepository.findByUser(user).orElseGet(() -> {
            DropOutUser newDropOutUser = new DropOutUser();
            newDropOutUser.setUser(user);
            return dropOutUserRepository.save(newDropOutUser);
        });

        log.info(dropOutUser.getUser().getUsername() + ": 탈퇴완료");

        return "redirect:/admin/user";
    }

    @GetMapping("/userUndelete/{id}")
    public String userUndelete(@PathVariable("id") Long id) {
        User user = userService.findById(id).orElseThrow(() -> new UsernameNotFoundException("없는 유저입니다"));

        DropOutUser dropOutUser = dropOutUserRepository.findByUser(user).orElseThrow(() -> new RuntimeException("탈퇴하지 않은 유저입니다"));

        int row = dropOutUserDAO.delete(dropOutUser.getId());

        log.info(row + "행 복구완료");

        return "redirect:/admin/user";
    }


    // 상품목록 추가
    @PostMapping("/addProductCategory")
    public String addProductCategory(ProductCategory productCategory) {
        int row = productService.addProductCategory(productCategory);
        log.info("상품목록" + row + "추가되었습니다");
        return "redirect:/admin/product";
    }

    // 좌석관리
    @GetMapping("/createSeat")
    public String seatTest(){
        seatService.createSeat();
        return "redirect:/";
    }


    @PostMapping("/addProduct")
    public String addProduct(ProductDTO productDTO) {
        log.info("상품생성");
        int row = productService.addProduct(productDTO);
        return "redirect:/admin/product";
    }

    @GetMapping("/viewProduct/{id}")
    @ResponseBody
    public ProductDTO viewProduct(@PathVariable("id") int id) {
        System.out.println("viewProduct들어옴");
        return productService.selectOne(id);
    }

    @PostMapping("/updateProduct/{id}")
    public String updateProduct(ProductDTO productDTO) {
        int row = productService.updateProduct(productDTO);
        log.info("상품목록" + row + "변경되었습니다");
        return "redirect:/admin/product";
    }

    // 상품삭제
    @GetMapping("/deleteProduct/{id}")
    public String deleteProduct(@PathVariable("id") int id) {
//        int row = productService.deleteProduct(id);

        productRepository.deleteById((long) id);

        return "redirect:/admin/product";
    }


    @GetMapping("/seat")
    public ModelAndView seat() {
        ModelAndView mav = new ModelAndView("/admin/seat_manage");
        List<SeatInfoDTO> seatList = seatService.selectSeatList();


        mav.addObject("seatList",seatList);
        mav.addObject("currentPage", "seat");

        return mav;
    }


    // 매출관리
    @GetMapping("/sales")
    public String sales(Model model) {
        model.addAttribute("currentPage", "sales");
        return "/admin/sales_manage";
    }

    // 이용권관리
    @GetMapping("/ticket")
    public ModelAndView ticket() {
        ModelAndView mav = new ModelAndView("/admin/ticket_manage");
        List<Ticket> ticketList = ticketService.selectTicketList();
        mav.addObject("ticketList", ticketList);
        mav.addObject("currentPage", "ticket");
        return mav;
    }

    @PostMapping("/add_update")
    public String add_update(@RequestParam("seat_state") Long  state, @RequestParam("hour") Integer  hour,
                             @RequestParam("seatId") Long  seatId){
        log.info( "state" + String.valueOf(state));
        log.info( "hour" + String.valueOf(hour));
        log.info( "seatId" + String.valueOf(seatId));
        int result = seatService.updateSeat(state, hour, seatId);
        log.info("result" + result);

        return "redirect:/admin/seat";
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
    public String productSale(Model model) {
        model.addAttribute("currentPage","productsales");
        return "/admin/product_sales_manage";
    }

    // 이용권 매출
    @GetMapping("/ticketsales")
    public ModelAndView ticketSale(HttpServletRequest request) throws ParseException {
        ModelAndView mav = new ModelAndView("/admin/ticket_sales_manage");
        mav.addObject("list", ticketSalesService.selectAll(request));
        log.info("티켓매출 불러옴");

        mav.addObject("total", ticketSalesService.selectTotal());
        log.info("총액 불러옴");
        mav.addObject("currentPage", "productsales");

        return mav;
    }

    // 회원관리
    @GetMapping("/user")
    public ModelAndView user(@RequestParam(required = false, defaultValue = "0") int page, @RequestParam(required = false, defaultValue = "10") int size, String type, String keyword) {
        PageRequest pageable = PageRequest.of(page, size, Sort.by("id").ascending());
        ModelAndView mav = new ModelAndView("/admin/user_manage");
        Page<UserAndLastLog> pages;
        if( type==null && keyword==null){
            pages = userService.findUserAndLastLog(pageable);
        }
        else {
            pages = userService.findUserAndLastLog(pageable, Objects.requireNonNull(type), keyword);
        }
        mav.addObject("page", pages);
        mav.addObject("currentPage", "user");
        List<DropOutUser> dropOutList = dropOutUserRepository.findAll();
        Map<Long, Boolean> dropOutMap = dropOutList.stream()
                .collect(Collectors.toMap(
                        dropOutUser -> dropOutUser.getUser().getId(),
                        dropOutUser -> true));

        mav.addObject("dropOutMap", dropOutMap);
        return mav;
    }

    // 탈퇴회원관리
    @GetMapping("/dropOutUser")
    public ModelAndView dropOutUser() {
        ModelAndView mav = new ModelAndView("/admin/dropOutUser_manage");

        return mav;
    }

    // 주문관리
    @GetMapping("/order")
    public String order(Model model) {
        model.addAttribute("currentPage", "order");
        return "/admin/order_manage";
    }
}
