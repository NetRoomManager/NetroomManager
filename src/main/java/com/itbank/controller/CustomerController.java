package com.itbank.controller;

import com.itbank.model.*;
import com.itbank.repository.jpa.OrderListRepository;
import com.itbank.repository.jpa.ProductRepository;
import com.itbank.repository.jpa.ProductSalesRepository;
import com.itbank.repository.mybatis.ProductCategoryDAO;
import com.itbank.repository.mybatis.ProductDAO;
import com.itbank.service.OrderDetailService;
import com.itbank.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/customer")
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
    private ProductDAO productDAO;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderDetailService orderDetailService;

    @GetMapping("/chat")
    public void chat() {
    }

    @GetMapping("/main")
    public void main() {
        // 유저랑 좌석연결
        // 임시로 좌석상태가 사용가능인곳 자동 배정
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
    public String detailOrder(@RequestBody List<Map<String,Object>> orderDetails) {
        System.out.println("orderDetail: " + orderDetails);


        Optional<OrderList> optionalOrderList = orderListRepository.findById(paymentService.findMaxId());
        OrderList orderList;
        if(optionalOrderList.isPresent()) {
            orderList = optionalOrderList.get();
        } else {
            orderList = null;
        }

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





            orderDetailService.addDetail(orderDetail1);
            System.out.println("controller orderDetail1 : "+orderDetail1);
        });
        return "성공";
    }

    @GetMapping("/recharge")
    public void recharge() {}

    @PostMapping("/buyProduct")
    @ResponseBody
    public Map<String, Boolean> buyProduct(@RequestBody PaymentResponse paymentResponse) throws UsernameNotFoundException {

        Map<String, Boolean> result = new HashMap<>();
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
        }else{
            result.put("success",false);
        }
        return result;
    }
}
