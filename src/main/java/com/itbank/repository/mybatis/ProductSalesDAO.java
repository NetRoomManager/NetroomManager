package com.itbank.repository.mybatis;

import com.itbank.model.dto.ProductItemDTO;
import com.itbank.model.dto.ProductSalesDTO;
import com.itbank.model.dto.TicketSalesDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ProductSalesDAO {

    List<ProductSalesDTO> proSalesAllSelect(Map<String, String> dates);

    Integer selectTotal(Map<String, String> dates);

    ProductSalesDTO proSalesSelectOne(Long id);

    List<ProductItemDTO> getProductListBySalesId(Long id);


}
