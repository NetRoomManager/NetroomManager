package com.itbank.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductItemDTO {

    // 제품 금액
    private Integer price;
    // 구매 제품
    private String productName;
    // 카운트
    private Integer count;

}
