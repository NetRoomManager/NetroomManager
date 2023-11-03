package com.itbank.repository.jpa;

import com.itbank.model.TicketSales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketSalesRepository extends JpaRepository<TicketSales, Long> {

}
