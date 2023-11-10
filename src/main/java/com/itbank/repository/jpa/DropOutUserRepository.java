package com.itbank.repository.jpa;

import com.itbank.model.DropOutUser;
import com.itbank.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface DropOutUserRepository extends JpaRepository<DropOutUser, Long> {

    Optional<DropOutUser> findByUser(User user);
}
