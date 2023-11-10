package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "order_list")
@Getter
@Setter
public  class OrderList extends Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User userId;

    @OneToOne
    @JoinColumn(name = "payment_id")
    @MapsId
    private Payment paymentId;

    // 결제정보에서 가져옴
    @Column(nullable = false)
    private Integer orderTotalPrice;
}

