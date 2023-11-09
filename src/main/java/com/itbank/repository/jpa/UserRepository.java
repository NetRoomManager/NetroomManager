package com.itbank.repository.jpa;

import com.itbank.model.SocialLogin;
import com.itbank.model.User;
import com.itbank.model.UserAndLastLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);

    Page<User> findAllByUsernameContaining(String username, Pageable pageable);

    Optional<User> findByEmailOrMobile(String email, String mobile);

    Optional<User> findByNameAndEmail(String name, String email);

    Optional<User> findByUsernameAndPassword(String username, String password);

    Page<User> findAllByNameContaining(String keyword, Pageable pageable);

    Page<User> findAllByMobileContaining(String keyword, Pageable pageable);

    Page<User> findAllByEmailContaining(String keyword, Pageable pageable);

    @Query("SELECT u FROM User u WHERE u.username LIKE %:keyword% OR u.email LIKE %:keyword% OR u.name LIKE %:keyword% OR u.mobile LIKE %:keyword%")
    Page<User> findAllByKeyword(@Param("keyword") String keyword, Pageable pageable);

}
