package com.itbank.repository;

import com.itbank.model.DropOutUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface DropOutUserRepository extends JpaRepository<DropOutUser, Long> {

}
