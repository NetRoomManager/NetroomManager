package com.itbank.service;

import com.itbank.model.TicketSales;
import com.itbank.model.dto.TicketSalesDTO;
import com.itbank.repository.jpa.TicketSalesRepository;
import com.itbank.repository.mybatis.TicketSalesDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class TicketSalesService {
    @Autowired
    private TicketSalesDAO ticketSalesDAO;

    public List<TicketSalesDTO> selectAll(HttpServletRequest request) throws ParseException {

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

        return ticketSalesDAO.selectAll(dates);
    }

//    public List<TicketSalesDTO> selectAll(HttpServletRequest request) {
//        Map<String, String> dates = new HashMap<>();
//        System.out.println(request.getParameter("startDate"));
//
//        dates.put("startDate", request.getParameter("startDate"));
//        dates.put("endDate", request.getParameter("endDate"));
//
//
//        return list;
//    }

    public Integer selectTotal() {
        Integer total = ticketSalesDAO.selectTotal();
        if(total == null){
            return 0;
        }
        System.out.println("total : " + total);
        return total;
    }
}
