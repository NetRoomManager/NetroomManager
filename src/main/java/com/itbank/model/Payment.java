package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Date;

@Getter
@Setter
@Table(name = "payment")
@Entity
@Slf4j
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreationTimestamp
    private Date time;

    @OneToOne
    @JoinColumn(name = "paymentMethod_id", nullable = true)
    private PaymentMethod paymentMethodId;
}
