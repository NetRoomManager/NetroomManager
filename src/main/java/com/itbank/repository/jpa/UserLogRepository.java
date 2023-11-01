package com.itbank.repository.jpa;

import com.itbank.model.User;
import com.itbank.model.UserLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserLogRepository extends JpaRepository<UserLog, Long> {

    // id가 가장 큰 UserLog를 반환하는 쿼리
    @Query("SELECT u FROM UserLog u WHERE u.user = ?1 ORDER BY u.id DESC")
    Page<UserLog> findLatestByUser(User user, Pageable pageable);
}
