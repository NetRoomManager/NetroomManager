package com.itbank.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "user_role")
@Getter
@Setter
public class UserRole implements Serializable {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch= FetchType.EAGER)
    @JoinColumn(name="user_id")
    @JsonBackReference
    private User user;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="role_id")
    @JsonBackReference
    private Role role;
}