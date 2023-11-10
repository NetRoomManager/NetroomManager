package com.itbank.service;

import com.itbank.model.dto.ProductItemDTO;
import com.itbank.model.dto.ProductSalesDTO;
import com.itbank.model.dto.TicketSalesDTO;
import com.itbank.repository.jpa.ProductSalesRepository;
import com.itbank.repository.mybatis.ProductSalesDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Slf4j
public class ProductSalesService {

    @Autowired
    private ProductSalesDAO productSalesDAO;



    public List<ProductSalesDTO> proSalesAllList(Map<String, String> dates) throws ParseException {
        log.info(dates.toString());
        return productSalesDAO.proSalesAllSelect(dates);

    }

    public Integer selectTotal(Map<String, String> dates) {
        Integer total = productSalesDAO.selectTotal(dates);

        if(total == null){
            return 0;
        }
        System.out.println("total : " + total);
        return total;
    }

    public ProductSalesDTO proSalesSelectOne(Long id) {
        // 매출상세조회
        ProductSalesDTO productSalesDTO = productSalesDAO.proSalesSelectOne(id);
        // 구매 제품 목록 리스트
        List<ProductItemDTO> productList = productSalesDAO.getProductListBySalesId(id);
        productSalesDTO.setProductList(productList);
        return productSalesDTO;
    }

    public Map<String, String> searchMap(HttpServletRequest request) {
        Map<String, String> dates = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String startParam = request.getParameter("startDate");
        String endParam = request.getParameter("endDate");


        if (startParam == null || startParam.isEmpty()) {
            startParam = "1970-01-01";
            dates.put("startDate", startParam);
        } else {
            dates.put("startDate", startParam);
        }

        if (endParam == null || endParam.isEmpty()) {
            endParam = sdf.format(new Date()).toString();
            log.info(endParam);
            dates.put("endDate", endParam);
        } else {
            dates.put("endDate", endParam);
        }
        return dates;
    }
}
