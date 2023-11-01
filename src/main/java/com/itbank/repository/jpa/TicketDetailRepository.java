package com.itbank.repository.jpa;

import com.itbank.model.Payment;
import com.itbank.model.PaymentMethod;
import com.itbank.model.TicketDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface TicketDetailRepository extends JpaRepository<TicketDetail, Long> {
}
