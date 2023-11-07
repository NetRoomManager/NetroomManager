package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Table(name="order_detail")
@Entity    // 상세 주문
@Getter
@Setter
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;	// 상세 주문 아이디

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderList orderList;	// 주문아이디

    @OneToOne
    @JoinColumn(name = "product_id")
    private Product product;	// 상품아이디

    private String memo; // 메모

    @Column(nullable = false)
    private Integer count;   // 수량

}

