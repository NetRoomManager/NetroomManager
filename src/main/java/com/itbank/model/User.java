package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Date;
import java.util.Set;

@Entity
@Table(name = "users")
@Getter
@Setter
public class    User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String password;

    private String mobile;

    @Column(nullable = false, unique = true)
    private String email;

    private Date birth;

    @Column(nullable = false)
    private String name;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private Set<UserRole> userRoles;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<SocialLogin> socialLogins;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private DropOutUser dropOutUser;
}