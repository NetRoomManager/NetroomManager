package com.itbank.service;

import com.itbank.model.dto.ProductSalesDTO;
import com.itbank.model.dto.TicketSalesDTO;
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

    public void addSale(TicketSalesDTO dto) {
    }

    public List<ProductSalesDTO> proSalesAllList(HttpServletRequest request) throws ParseException {
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

        return productSalesDAO.proSalesAllSelect(dates);

    }
}
