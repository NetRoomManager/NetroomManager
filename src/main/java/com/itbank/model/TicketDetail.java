package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "ticket_detail")
@Getter
@Setter
public class TicketDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "payment_id", nullable = false)
    private Payment paymentId;

    @OneToOne
    @JoinColumn(name = "ticket_id", nullable = false)
    private Ticket ticketId;
}
