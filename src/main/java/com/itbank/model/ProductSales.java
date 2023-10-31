package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Date;

// 매출
@Table(name = "product_sales")
@Entity
@Getter
@Setter
public class ProductSales {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "payment_id", nullable = false)
    private Payment paymentId;

    // 매출일자
    @Column(nullable = false, unique = true)
    private Date searchDate;

    // 총 매출 금액
    @Column(nullable = false)
    private Integer totalPrice;

}
