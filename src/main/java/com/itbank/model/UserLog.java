package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.annotation.CreatedBy;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Table(name = "user_log")
@Entity
@Getter
@Setter
public class UserLog implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @CreationTimestamp
    private Date loginAt;

    private Date logoutAt;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

}
