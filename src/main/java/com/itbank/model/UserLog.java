package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;

import javax.persistence.*;
import java.util.Date;

@Table(name = "user_log")
@Entity
@Getter
@Setter
public class UserLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreationTimestamp
    private Date loginAt;

    @UpdateTimestamp
    private Date logoutAt;

    @Column(nullable = false, columnDefinition = "INTEGER DEFAULT 0")
    private int remain_time;


}
