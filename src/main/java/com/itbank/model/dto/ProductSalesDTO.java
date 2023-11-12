package com.itbank.model.dto;

import com.itbank.model.ProductDTO;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
public class ProductSalesDTO {
    // 매출번호
    private Long id;
    // 결제 번호
    private Long paymentId;
    // 결제방식
    private String paymentMethod;
    // 결제 금액
    private Integer orderTotalPrice;

    // 판매시간
    private Date salesDate;
    // 구매 회원 아이디
    private String username;
    // 메모
    private String memo;

    private List<ProductItemDTO> productList;


}
