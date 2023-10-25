package com.itbank.repository;

import com.itbank.model.Payment;
import com.itbank.model.PaymentMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {

    Optional<Payment> findByPaymentMethodId(PaymentMethod paymentMethod);
}
