package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Table(name="order_Detail")
@Entity    // 상세 주문
@Getter
@Setter
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderDetailId;	// 상세 주문 아이디

    @ManyToOne
    @JoinColumn(name = "orderId")
    private OrderList orderId;	// 주문아이디

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product productId;	// 상품아이디

    @ManyToOne
    @JoinColumn(name = "productCateId")
    private ProductCategory productCategoryId;	// 상품 카테고리 아이디

    private String orderDetailMemo; // 메모

    @Column(nullable = false)
    private Integer orderDetailCount;   // 수량

}

