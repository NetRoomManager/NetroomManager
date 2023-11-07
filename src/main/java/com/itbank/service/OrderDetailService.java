package com.itbank.service;

import com.itbank.model.OrderDetail;
import com.itbank.repository.jpa.OrderDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderDetailService {
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public void addDetail(OrderDetail orderDetail1) {
        OrderDetail orderDetail = orderDetailRepository.save(orderDetail1);
        System.out.println("test :" + orderDetail.getMemo());
    }
}
