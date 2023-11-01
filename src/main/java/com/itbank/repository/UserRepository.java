package com.itbank.repository;

import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.model.UserAndLastLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);

    List<User> findAllByUsernameContaining(String username);

    Optional<User> findByEmailOrMobile(String email, String mobile);

    Optional<User> findByNameAndEmail(String name, String email);

    Optional<User> findByUsernameAndPassword(String username, String password);

    List<User> findAllByNameContaining(String keyword);

    List<User> findAllByMobileContaining(String keyword);

    List<User> findAllByEmailContaining(String keyword);

    @Query("SELECT u FROM User u WHERE u.username LIKE %:keyword% OR u.email LIKE %:keyword% OR u.name LIKE %:keyword% OR u.mobile LIKE %:keyword%")
    List<User> findAllByKeyword(@Param("keyword") String keyword);

}
