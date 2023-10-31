package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Date;

@Table(name = "ticket_sales")
@Entity
@Getter
@Setter
public class TicketSales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "payment_id", nullable = false)
    private Payment paymentId;

    @CreationTimestamp
    private Date salesDate;

    // 총 매출 금액
    @Column
    private Integer totalPrice;

}
