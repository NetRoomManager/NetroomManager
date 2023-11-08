package com.itbank.repository.mybatis;

import com.itbank.model.dto.ProductSalesDTO;
import com.itbank.model.dto.TicketSalesDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Repository
public interface ProductSalesDAO {

    List<ProductSalesDTO> proSalesAllSelect(Map<String, String> dates);


    // 총 금액
    Integer selectTotal();
}
