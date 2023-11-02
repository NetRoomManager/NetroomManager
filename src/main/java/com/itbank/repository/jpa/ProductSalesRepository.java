package com.itbank.repository.jpa;

import com.itbank.model.ProductSales;
import com.itbank.model.dto.TicketSalesDTO;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductSalesRepository extends JpaRepository <ProductSales, Long> {
    // 상품 매출
}
