package com.itbank.controller;

import com.itbank.model.*;
import com.itbank.model.dto.Summoner;
import com.itbank.repository.jpa.OrderListRepository;
import com.itbank.repository.jpa.TicketSalesRepository;
import com.itbank.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@Slf4j
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderListRepository orderListRepository;

    @Autowired
    private TicketSalesRepository ticketSalesRepository;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private AuthService authService;

    @Autowired
    private SeatService seatService;

    @Autowired
    private RiotAPIService riotAPIService;

    @GetMapping("/login")
    public String login() {
       /* // 임시로 좌석상태를 불러와서
        List<Object[]> seatList = seatService.selectSeatList();
        for( Object[] s : seatList){
            if(s.getClass().get == 1){  // 이용가능 좌석일 경우 login*/
                return "/auth/login";
 /*           }
        }
        // 사용불가면 사용불가jsp로 보내기
        return "/auth/cant_use_form";*/
    }

    @GetMapping("/test")
    public String test() {
        userService.testAdmin();
        return "redirect:/auth/login";
    }

    @GetMapping("/create_admin")
    public String create_admin(HttpServletRequest request) {

        log.info("관리자 생성");
        User user = new User();
        user.setUsername("admin");
        user.setMobile("010-9999-9999");
        user.setPassword("1234");
        user.setName("admin");
        user.setEmail("admin@naver.com");
        user.setBirth(null);

        userService.createAdmin(user);

        log.info("유저 생성 완료!!");

        // 사용자의 이름과 권한을 가져와서 Authentication 객체를 만듭니다.
        UserDetails userDetails = userDetailsService.loadUserByUsername(user.getUsername());
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

        // 만든 Authentication 객체를 SecurityContext에 설정합니다.
        SecurityContextHolder.getContext().setAuthentication(authentication);

        // 세션에 SPRING_SECURITY_CONTEXT라는 키 값으로 SecurityContext를 저장합니다.
        HttpSession session = request.getSession(true);
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());

        return "redirect:/";
    }

    @GetMapping("/createUsers")
    public String createUsers(){
        log.info("임시 user 생성");
        for(int i = 1; i  < 11; i++){

            User user = new User();
            user.setUsername("user" + i);
            user.setMobile(null);
            user.setPassword("1234");
            user.setName("user" + i);
            user.setEmail("admin" + i + "@naver.com");
            user.setBirth(null);

            userService.createUsers(user);
        }

        return "redirect:/";
    }

    @PostMapping("/join")
    public String join(User user, HttpServletRequest request) {

        log.info("유저 생성");

        userService.createUsers(user);

        log.info("유저 생성 완료!!");

        return "redirect:/auth/login";
    }

    // 좌석관리
    @GetMapping("/seat")
    public String seatTest(){
        seatService.createSeat();
        return "redirect:/";
    }

    @GetMapping("/loginSuccess")
    public void loginSuccess() {
    }

    @GetMapping("/buyTicket")
    public ModelAndView buyTicket() {
        ModelAndView mav = new ModelAndView("/auth/buyTicket");

        List<User> list = userService.findAll();
        List<Ticket> ticketList = ticketService.selectTicketList();

        mav.addObject("list", list);
        mav.addObject("ticketList", ticketList);

        return mav;
    }

    @PostMapping("/buyTicket")
    @ResponseBody
    public Map<String, Boolean> buyTicket(@RequestBody PaymentResponse paymentResponse) throws UsernameNotFoundException {

        Map<String, Boolean> result = new HashMap<>();
        if(paymentResponse.isSuccess()){

            Payment payment = paymentService.buyTicket(paymentResponse);


            Optional<OrderList> orderList = orderListRepository.findById(payment.getId());

            Integer totalPrice = null;
            if(orderList.isPresent()) {
                totalPrice = orderList.get().getOrderTotalPrice();
            }

            TicketSales ticketSales = new TicketSales();
            ticketSales.setPaymentId(payment);
            ticketSales.setTotalPrice(totalPrice);
            ticketSales.setSalesDate(payment.getTime());

            ticketSalesRepository.save(ticketSales);



            result.put("success", true);
        }else{
            result.put("success",false);
        }
        return result;
    }

    @PostMapping("/checkId")
    @ResponseBody
    public Map<String, Boolean> checkId(@RequestBody User user) {
        // 받은 유저 아이디로 검색해서 중복이면 true 아니면 false
        boolean duplicate = userService.checkId(user.getUsername()).isEmpty();
        Map<String, Boolean> result = new HashMap<>();
        result.put("duplicate", duplicate);
        return result;
    }

    @PostMapping("/checkAuthNumber")
    @ResponseBody
    public Map<String, Boolean> checkAuthNumber(@RequestBody Map<String, Object> reauestBody, HttpSession session) {
        int authNumber = (int) reauestBody.get("authNumber");
        Map<String, Boolean> result = new HashMap<>();
        if(session.getAttribute("authNumber") != null){
            boolean emailCheck = authService.checkAuthNumber(authNumber, session);
            result.put("emailCheck", emailCheck);
            log.info("authNumber" + String.valueOf(authNumber));
            log.info("session.getAttribute(authNumber)" + session.getAttribute("authNumber"));
            System.out.println("result" + result);
        }else{
            result.put("emailCheck", false);
        }
        return result;
    }

    @GetMapping("/sendAuthNumber")
    @ResponseBody
    public String sendAuthNumber(String email, HttpSession session){
        log.info("인증번호 전송");
        HashMap<String, Integer> authHash = authService.sendAuthNumber(email,session);
        String msg;
        if(authHash.get("row") != 1){
            msg = "인증번호 발송에 실패했습니다";
            log.info("msg : " + msg);
        }
        else{
            msg = "인증번호가 발송되었습니다";
            session.setAttribute("authNumber", authHash.get("authNumber"));
            session.setMaxInactiveInterval(180);
            log.info("msg : " + msg);
            log.info("session.get(authNumber) : " + session.getAttribute("authNumber"));
            log.info("session.getMaxInactiveInterval() : " + session.getMaxInactiveInterval());
        }

        return msg;
    }

    @GetMapping("/summoner/{lolid}")
    @ResponseBody
    public Summoner getSummonerTire(@PathVariable("lolid") String lolid) {
        return riotAPIService.getSummoner(lolid);
    }
}
