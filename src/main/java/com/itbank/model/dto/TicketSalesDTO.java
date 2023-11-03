package com.itbank.model.dto;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class TicketSalesDTO {
    // 매출번호
    private Long id;
    // 결제방식
    private String paymentMethod;
    // 상품명
    private String ticketName;
    // 결제 금액
    private Integer orderTotalPrice;
    // 판매시간
    private Date salesDate;
    // 구매 회원 아이디
    private String username;
    // 결제 번호
    private Long paymentId;
}
