package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "users")
@Getter
@Setter
public class User implements Serializable {
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

    @OneToMany(mappedBy = "user",  fetch = FetchType.EAGER)
    private List<UserLog> userLogs;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    @PrimaryKeyJoinColumn
    private RemainingTime remainingTime;

    private String summoner;

    private String tire;
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password'********" +  + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", birth=" + birth +
                ", name='" + name + '\'' +
                ", userRoles=" + userRoles +
                ", socialLogins=" + socialLogins +
                ", dropOutUser=" + dropOutUser +
                ", userLogs=" + userLogs +
                ", remainingTime=" + remainingTime +
                ", summoner='" + summoner + '\'' +
                ", tire='" + tire + '\'' +
                '}';
    }

}