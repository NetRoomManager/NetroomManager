package com.itbank.service;

import com.itbank.model.Ticket;
import com.itbank.repository.jpa.TicketRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;



    public int addTicket(Ticket ticket) {
        Ticket saveTicket =  ticketRepository.save(ticket);
        log.info(String.valueOf(saveTicket));
        if(saveTicket.getId() > 0){
            return  1;
        }
        return  0;
    }

    public List<Ticket> selectTicketList() {
        List<Ticket> ticketList = ticketRepository.findAll(Sort.by(Sort.Direction.DESC,"id"));
        return ticketList;
    }

    public int updateTicket(Ticket ticket) {
        Optional<Ticket> t =  ticketRepository.findById(ticket.getId());
        if(t.isPresent()){  // 객체에 값이 있는지 확인 true | false
            Ticket updateTicket = t.get();
            updateTicket.setId(ticket.getId());
            updateTicket.setName(ticket.getName());
            updateTicket.setTime(ticket.getTime());
            updateTicket.setPrice(ticket.getPrice());
            ticketRepository.save(updateTicket);
            log.info(updateTicket.getId() + "번 이용권 변경");
            return 1;
        }
        return  0;
    }

    public int deleteTicket(int ticketId) {
        try{
            if(ticketId > 0){
                ticketRepository.deleteById((long) ticketId);
                return 1;
            }
            return 0;
        }
        catch (Exception e){
            e.printStackTrace();
            return -1;
        }
    }
}
