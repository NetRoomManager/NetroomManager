package com.itbank.controller;

import com.itbank.config.UserPrincipal;
import com.itbank.model.*;
import com.itbank.model.dto.SeatInfoDTO;
import com.itbank.repository.jpa.*;
import com.itbank.repository.mybatis.ProductCategoryDAO;
import com.itbank.repository.mybatis.ProductDAO;
import com.itbank.service.*;
import com.itbank.wersocketConfig.ChatComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import redis.clients.jedis.Jedis;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/customer")
@Slf4j
public class CustomerController {
    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderListRepository orderListRepository;

    @Autowired
    private ProductSalesRepository productSalesRepository;

    @Autowired
    private ProductCategoryDAO productCategoryDAO;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ChatComponent chatComponent;

    @Autowired
    private UserLogService userLogService;

    @Autowired
    private Jedis jedis;

    @Autowired
    private SeatService seatService;

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/chat")
    public void chat() {
    }

    @GetMapping("/main")
    public ModelAndView main() {

        ModelAndView mav = new ModelAndView("/customer/main");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
        log.info("Principal type: " + principal.toString());
        UserPrincipal userPrincipal = (UserPrincipal) principal;

        User user = userPrincipal.getUser();
        user = userRepository.findByUsername(user.getUsername()).orElseThrow(()->new UsernameNotFoundException("유저 정보를 찾을 수 없습니다."));

        if (user != null && user.getRemainingTime() != null && jedis.ttl(user.getUsername() + " " + user.getRemainingTime().getRemainingTime()) == -2) {
            System.out.println(1);
            redisTemplate.opsForValue().set(user.getUsername()+" "+user.getRemainingTime().getRemainingTime(), user.getRemainingTime().getRemainingTime(), user.getRemainingTime().getRemainingTime(), TimeUnit.SECONDS);
            mav.addObject("user", user);
            mav.addObject("userLog", userLogService.findLatestByUser(user).get());
            long l = user.getRemainingTime().getRemainingTime() - jedis.ttl(user.getUsername() + " " + user.getRemainingTime().getRemainingTime());
            log.info("사용시간: " + l);
            mav.addObject("usingTime", l);
            mav.addObject("remainingTime", jedis.ttl(user.getUsername() + " " + user.getRemainingTime().getRemainingTime()));

            log.info("user: " + user);
            log.info("userLog: " + user.getUserLogs());
        }
        else if(seatRepository.findByUser(user).isPresent()) {
            System.out.println(2);
            mav.addObject("user", user);
            mav.addObject("userLog", userLogService.findLatestByUser(user).get());
            long l = user.getRemainingTime().getRemainingTime() - jedis.ttl(user.getUsername() + " " + user.getRemainingTime().getRemainingTime());
            log.info("사용시간: " + l);
            mav.addObject("usingTime", l);
            mav.addObject("remainingTime", jedis.ttl(user.getUsername() + " " + user.getRemainingTime().getRemainingTime()));

            log.info("user: " + user);
            log.info("userLog: " + user.getUserLogs());
        }
        else {
            System.out.println(3);
            mav.setViewName("/customer/seat_view");
        }
        return mav;
    }

    @GetMapping("/seat")
    public ModelAndView seat_view() {
        ModelAndView mav = new ModelAndView("/customer/seat_view");
        List<SeatInfoDTO> seatList = seatService.selectSeatList();
        mav.addObject("seatList",seatList);
        return mav;
    }
    @GetMapping("/order/{id}")
    public ModelAndView order(@PathVariable Long id) {
        ModelAndView mav = new ModelAndView("/customer/order");
        List<ProductCategory> cate_list = productCategoryDAO.selectAll();
        List<Product> product_list = productDAO.selectByCategoryId(id);
        mav.addObject("productcategory_list",cate_list);
        mav.addObject("product_list", product_list);

        return mav;
    }

    @PostMapping("/order/addDetail")
    @ResponseBody
    public String detailOrder(@RequestBody Map<String,Object> param) {
        System.out.println("orderDetail: " + param);


        Optional<OrderList> optionalOrderList = orderListRepository.findById(paymentService.findMaxId());
        OrderList orderList;
        orderList = optionalOrderList.orElse(null);

        List<Map<String, Object>> orderDetails = (List<Map<String, Object>>) param.get("menuList");
        String payMethod = (String) param.get("pay_method");

        System.out.println("list: " + orderDetails);
        System.out.println("pay: " + payMethod);

        orderDetails.forEach(e -> {
            System.out.println("e: " + e.get("p_id"));
            OrderDetail orderDetail1 = new OrderDetail();
            orderDetail1.setCount(Integer.parseInt(e.get("amount").toString()));
            System.out.println("2."+e.get("amount").toString());

            orderDetail1.setProduct(productRepository.findById(Long.parseLong(e.get("p_id").toString())).orElseGet(()->{
                System.out.println("타나??");
                return null;
            }));
            System.out.println("3."+e.get("p_id").toString());

            orderDetail1.setOrderList(orderList);

            System.out.println(Objects.requireNonNull(orderList).getId() + "주문에 상세주문 1건 추가");

            System.out.println("1."+e.get("memo").toString());
            orderDetail1.setMemo(e.get("memo").toString());


            HashMap<String, Object> map = new HashMap<>();
            map.put("title", e.get("name").toString());
            map.put("description", e.get("memo").toString());
            map.put("price",e.get("priceValue").toString());
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy / MM / dd");
            Date currentDate = new Date();
            String formattedDate = dateFormat.format(currentDate);

            map.put("orderDate", formattedDate);
            map.put("payment_method", payMethod);

            log.info("map: " + map);

            chatComponent.convertAndSendToUser("admin", "/queue/order", map);


            orderDetailService.addDetail(orderDetail1);
        });
        return "성공";
    }

    @GetMapping("/recharge")
    public void recharge() {}

    @PostMapping("/buyProduct")
    @ResponseBody
    public Map<String, Object> buyProduct(@RequestBody PaymentResponse paymentResponse) throws UsernameNotFoundException {

        Map<String, Object> result = new HashMap<>();
        if(paymentResponse.isSuccess()){
            System.out.println("name:"+paymentResponse.getName());
            Payment payment = paymentService.buyProduct(paymentResponse);

            Optional<OrderList> orderList = orderListRepository.findById(payment.getId());

            Integer totalPrice = null;
            if(orderList.isPresent()) {
                totalPrice = orderList.get().getOrderTotalPrice();
            }

            ProductSales productSales = new ProductSales();
            productSales.setPaymentId(payment);
            productSales.setTotalPrice(totalPrice);
            productSales.setSearchDate(payment.getTime());

            productSalesRepository.save(productSales);

            result.put("success", true);
            result.put("pay_method", paymentResponse.getPay_method().toString());
        }else{
            result.put("success",false);
        }
        return result;
    }

    @GetMapping("/seatSelector")
    public String seatSelector(Long seatId) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();

        User user = userPrincipal.getUser();

        log.info("유저: " + user);

        // 다른 좌석 사용중이라면 해당 좌석을 먼저 삭제
        Optional<Seat> optionalSeat = seatRepository.findByUser(user);
        if(optionalSeat.isPresent()) {
            Seat seat = optionalSeat.get();
            seat.setSeatState(1L);
            seat.setUser(null);
            seatRepository.save(seat);
        }

        // 이후 선택한 좌석에 등록
        Seat seat = seatRepository.findById(seatId).orElseThrow(() -> new IllegalArgumentException("잘못된 접근입니다."));
        seat.setUser(user);
        seatRepository.save(seat);

        log.info(seatId + "번 좌석: 사용중");

        return "redirect:/customer/main";
    }
}
