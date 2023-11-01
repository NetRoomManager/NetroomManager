package com.itbank.repository.jpa;

import com.itbank.model.RemainingTime;
import com.itbank.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RemainingTimeRepository extends JpaRepository<RemainingTime, Long> {

    Optional<RemainingTime> findByUser(User user);
}

