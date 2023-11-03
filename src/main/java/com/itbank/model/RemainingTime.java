package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Date;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "remaining_time")
@Getter
@Setter
public class RemainingTime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Integer remainingTime;

    @OneToOne
    @MapsId
    @JoinColumn(name = "user_id")
    private User user;
}