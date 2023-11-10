package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import reactor.util.annotation.Nullable;

import javax.persistence.*;
@Entity
@Getter
@Setter
@Table(name = "seat")
public class Seat { // 데이터베이스 테이블과 매핑되는 엔티티 클래스로 사용
    //  @Entity: JPA(Java Persistence API)에서 엔티티 클래스를 표시할 때 사용
    @Id
    private Long seatId;

    @Column(nullable = false)
    private Long seatState = 1L;    // 사용 가능 상태

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", unique = true)
    private User user;


    @Column(nullable = false)
    private String seatIpAddr;

}