package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "order_list")
@Getter
@Setter
public  class OrderList {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User userId;

    @Column(nullable = false)
    private String orderMethod;

    // null -> 상세주문 입력 후 가져옴
    private Integer orderTotalPrice;
}

