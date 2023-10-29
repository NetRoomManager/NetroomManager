package com.itbank.repository;

import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);

    Optional<User> findByEmailOrMobile(String email, String mobile);

    Optional<User> findBySocialLogins(SocialLogin socialLogin);

    Optional<User> findByNameAndEmail(String name, String email);

    Optional<User> findByUsernameAndPassword(String username, String password);
}
