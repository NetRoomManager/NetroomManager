package com.itbank.service;

import com.itbank.model.Ticket;
import com.itbank.repository.TicketRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    public void createTicket(Ticket paramTicket) {
        log.info("이용권을 생성합니다");

        Ticket ticket = new Ticket();
        ticket.setName(paramTicket.getName());
        ticket.setTime(paramTicket.getTime());
        ticket.setPrice(paramTicket.getPrice());
        ticketRepository.save(ticket);
    }
}
