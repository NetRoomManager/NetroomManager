package com.itbank.service;

import com.itbank.model.*;
import com.itbank.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PaymentService {

    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private TicketDetailRepository ticketDetailRepository;

    @Autowired
    private OrderListRepository orderListRepository;

    public void buyTicket(PaymentResponse paymentResponse) {
        String payMethod = paymentResponse.getPg_provider();

        PaymentMethod paymentMethod = paymentMethodRepository.findByName(payMethod).orElseGet(() -> {

            PaymentMethod newPaymentMethod = new PaymentMethod();
            newPaymentMethod.setName(payMethod);
            return paymentMethodRepository.save(newPaymentMethod);
        });

        System.out.println("payMethod 가져옴");

        Payment payment = new Payment();
        payment.setPaymentMethodId(paymentMethod);
        payment = paymentRepository.save(payment);

        System.out.println("pay 가져옴");

        int totalPrice = paymentResponse.getPaid_amount();
        String buyerName = paymentResponse.getBuyer_name();
        String buyerEmail = paymentResponse.getBuyer_email();
        String name = paymentResponse.getName();

        User user = userRepository.findByNameAndEmail(buyerName, buyerEmail).orElseGet(() -> {
            throw new UsernameNotFoundException("유저정보를 찾을 수 없습니다.");
        });

        System.out.println("유저 가져옴");

        OrderList orderList = new OrderList();
        orderList.setPaymentId(payment);
        orderList.setUserId(user);
        orderList.setOrderTotalPrice(totalPrice);
        orderListRepository.save(orderList);

        System.out.println("주문정보 가져옴");

        Ticket ticket = ticketRepository.findByName(name).orElseGet(()->{
            System.out.println("티켓 만드는중");
            Ticket newTicket = new Ticket();
            newTicket.setName(name);
            newTicket.setPrice(totalPrice);
            newTicket.setTime(100);
            return ticketRepository.save(newTicket);
        });

        System.out.println("티켓 가져옴");

        TicketDetail ticketDetail = new TicketDetail();
        ticketDetail.setTicketId(ticket);
        ticketDetail.setPaymentId(payment);
        ticketDetailRepository.save(ticketDetail);

        System.out.println("티켓 상세정보 가져옴");


    }
}
