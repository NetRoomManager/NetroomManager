package com.itbank.controller;

import com.itbank.model.Ticket;
import com.itbank.model.dto.ProductSalesDTO;
import com.itbank.model.*;
import com.itbank.model.dto.SeatInfoDTO;
import com.itbank.repository.jpa.DropOutUserRepository;
import com.itbank.repository.jpa.ProductRepository;
import com.itbank.repository.jpa.ProductSalesRepository;
import com.itbank.repository.jpa.SeatRepository;
import com.itbank.repository.mybatis.DropOutUserDAO;
import com.itbank.service.*;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;
import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.List;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;
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
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private DropOutUserRepository dropOutUserRepository;

    @Autowired
    private Jedis jedis;

    @Autowired
    private ChatComponent chatComponent;

    @Autowired
    private DropOutUserDAO dropOutUserDAO;

    @Autowired
    private ProductSalesService productSalesService;

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
    public String seatTest() {
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


        mav.addObject("seatList", seatList);
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
    public String add_update(@RequestParam("seat_state") Long state, @RequestParam("hour") Long hour,
                             @RequestParam("seatId") Long seatId) {
        log.info("state" + String.valueOf(state));
        log.info("hour" + String.valueOf(hour));
        log.info("seatId" + String.valueOf(seatId));

        /*
        기존 Redis에 저장된 키의 만료시간을 불러옴
        기존 Key를 삭제
        새로운 시간으로 레디스 키를 저장
        만료시간은 새로운 시간 - (이전 남은시간 - 이전 레디스 남은 만료시간)
         */
        if (hour == 1) {
            hour = 60L;
        } else if (hour == 2) {
            hour = 120L;
        } else if (hour == 3) {
            hour = 180L;
        } else if (hour == 4) {
            hour = 240L;
        } else if (hour == 5) {
            hour = 300L;
        } else if (hour == 6) {
            hour = 360L;
        } else {
            hour = 0L;
        }
        Seat seat = seatRepository.findById(seatId).orElseThrow(() -> new IllegalArgumentException("잘못된 접근입니다."));
        if (seat.getUser() != null) {
            // 남은 만료시간
            Long ttl = jedis.ttl(seat.getUser().getUsername() + " " + seat.getUser().getRemainingTime().getRemainingTime());
            // 기존키 삭제
            log.info(seat.getUser().getUsername() + " " + seat.getUser().getRemainingTime().getRemainingTime() + "삭제");
            Set<String> keys = redisTemplate.keys(seat.getUser().getUsername() + " *");
            System.out.println("삭제할 키 : " + keys);
            if (keys != null) {
                for (String key : keys) {
                    redisTemplate.delete(key);
                }
            }

            // 사용시간
            Long usingTime = seat.getUser().getRemainingTime().getRemainingTime() - ttl;

            log.info("사용시간: " + usingTime);
            log.info("만료시간: " + ttl);

            int time = (int) (ttl + hour);

            // DB에 시간 반영
            int result = seatService.updateSeat(state, time, seatId);
            seat = seatRepository.findById(seat.getSeatId()).orElseThrow(() -> new IllegalArgumentException("잘못된 접근입니다."));

            redisTemplate.opsForValue().set(seat.getUser().getUsername() + " " + (time + usingTime), time , time - ttl, TimeUnit.SECONDS);


            log.info("레디스에 저장한 값: " + seat.getUser().getUsername() + " " + time);
            log.info("DB에 저장한 값: " + seat.getUser().getRemainingTime().getRemainingTime());
            log.info("time: " + time);

            log.info("result" + result);

            Message message = new Message("admin", time + "초 추가", seat.getUser().getUsername(), new Date());
            chatComponent.saveMessage(message);
            chatComponent.convertAndSendToUser(seat.getUser().getUsername(), "/queue/messages", message);
        } else {
            seatService.updateState(seatId, state);
        }


        return "redirect:/admin/seat";
    }

    @PostMapping("/ticketRegister")
    public String addTicket(Ticket ticket) {
        if (ticket.getId() == null) {
            log.info("이용권 추가 form");
            int i = ticketService.addTicket(ticket);
            log.info(i + "개의 이용권이 추가되었습니다");
        } else {
            log.info(ticket.getId() + "번 이용권 변경");
            int i = ticketService.updateTicket(ticket);
            log.info(i + "개의 이용권이 변경되었습니다 :  이용권 번호 [" + ticket.getId() + "]");
        }
        return "redirect:/admin/ticket";
    }

    @GetMapping("/deleteTicket/{ticketId}")
    public String deleteTicket(@PathVariable int ticketId) {
        log.info(ticketId + "번 이용권 삭제");
        int i = ticketService.deleteTicket(ticketId);
        log.info(i + "개의 이용권을 삭제하였습니다");
        return "redirect:/admin/ticket";
    }


    // 상품 상세 매출
    @PostMapping("/productsalesDetail")
    @ResponseBody
    public HashMap<String, Object> proSalesSelectOne(@RequestParam("id") Long  id){
        log.info( "id" + id);
        ProductSalesDTO proSalesSelectOne = productSalesService.proSalesSelectOne(id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("dto", proSalesSelectOne);
        map.put("ok", true);

        return map;
    }


    // 상품 매출
    @GetMapping("/productsales")
    public ModelAndView productSale(HttpServletRequest request) throws ParseException {
        ModelAndView mav = new ModelAndView("/admin/product_sales_manage");
        // 매출 리스트 조인해서 리스트 보내기
        Map<String, String> dates = productSalesService.searchMap(request);
        List<ProductSalesDTO> proSalesList = productSalesService.proSalesAllList(dates);
        Integer orderTotalPrice = productSalesService.selectTotal(dates);

        log.info("productList.size() : " + proSalesList.size());
        log.info("상품 매출 불러오기");
        log.info("총액 불러옴 " + orderTotalPrice);
        mav.addObject("currentPage","productsales");
        mav.addObject("proSalesList",proSalesList);
        mav.addObject("orderTotalPrice",orderTotalPrice);

        return mav;
    }

    // 이용권 매출
    @GetMapping("/ticketsales")
    public ModelAndView ticketSale(HttpServletRequest request) throws ParseException {
        ModelAndView mav = new ModelAndView("/admin/ticket_sales_manage");

        Map<String, String> dates = productSalesService.searchMap(request);
        mav.addObject("list", ticketSalesService.selectAll(dates));
        log.info("티켓매출 불러옴");

        mav.addObject("total", ticketSalesService.selectTotal(dates));
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
        if (type == null && keyword == null) {
            pages = userService.findUserAndLastLog(pageable);
        } else {
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
    public ModelAndView dropOutUser(@RequestParam(required = false, defaultValue = "0") int page, @RequestParam(required = false, defaultValue = "10") int size) {
        PageRequest pageable = PageRequest.of(page, size, Sort.by("id").ascending());
        ModelAndView mav = new ModelAndView("/admin/dropOutUser_manage");
        Page<DropOutUser> dropOutUsers = dropOutUserRepository.findAll(pageable);
        mav.addObject("page", dropOutUsers);
        mav.addObject("currentPage", "user");
        return mav;
    }

    // 주문관리
    @GetMapping("/order")
    public String order(Model model) {
        model.addAttribute("currentPage", "order");
        return "/admin/order_manage";
    }

    @GetMapping("/getOrders")
    @ResponseBody
    public List<List<String>> getOrders() {

        List<List<String>> list = chatComponent.getOrders();

        System.out.println(list);

        return list;
    }

    @DeleteMapping("/deleteOrder")
    public ResponseEntity<?> deleteOrder(@RequestBody Map<String, String> payload) {
        String key = payload.get("key");
        Long result = jedis.del(key);
        if (result > 0) {
            return ResponseEntity.ok(Collections.singletonMap("success", true));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("success", false));
        }
    }

}
