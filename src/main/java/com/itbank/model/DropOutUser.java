package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import reactor.util.annotation.Nullable;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "drop_out_user")
@Getter
@Setter
public class DropOutUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.EAGER, optional = true)
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @CreationTimestamp
    private Date dropAt;


}
