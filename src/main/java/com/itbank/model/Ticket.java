package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "ticket")
@Getter
@Setter
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;    // 이용권 고유번호

    @Column(nullable = false)   //이용권이름
    private String name;

    @Column(nullable = false)
    private Integer price;

    @Column(nullable = false)   // 시간정보
    private Integer time;
}
