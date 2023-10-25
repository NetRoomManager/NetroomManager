package com.itbank.repository;

import com.itbank.model.OrderList;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface OrderListRepository extends JpaRepository<OrderList, Long> {

}
