package com.itbank.repository.jpa;

import com.itbank.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TicketRepository  extends  JpaRepository<Ticket, Long> {
    Optional<Ticket> findByName(String name);
}


