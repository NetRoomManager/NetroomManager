package com.itbank.controller;

import com.itbank.model.Product;
import com.itbank.model.ProductCategory;
import com.itbank.model.ProductDTO;
import com.itbank.service.ProductService;
import com.itbank.service.UserService;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy._Proxy_;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    // 상품관리
    @GetMapping("/product")
    public ModelAndView product() {
        ModelAndView mav = new ModelAndView("/admin/product_manage");
        List<ProductDTO> productList = productService.selectAllProduct();
        List<ProductCategory> productCategoryList = productService.selectAllProductCategory();
        mav.addObject("productList", productList);
        mav.addObject("productCategoryList", productCategoryList);
        return mav;
    }

    // 상품목록 추가
    @PostMapping("/addProductCategory")
    public String addProductCategory(ProductCategory productCategory) {
        int row = productService.addProductCategory(productCategory);
        log.info("상품목록" + row + "추가되었습니다");
        return "redirect:/admin/product";
    }

    // 신규상품 추가
//    @PostMapping("/addProduct")
//    public String addProduct(Product product, @RequestParam("img")MultipartFile img) {
//        productService.addProduct(product, img);
//        log.info("상품 생성");
//        return "redirect:/admin/product";
//    }
    @PostMapping("/addProduct")
    public String addProduct(ProductDTO productDTO) {
        log.info("상품생성");
        int row = productService.addProduct(productDTO);
        return "redirect:/admin/product";
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
