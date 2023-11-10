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

    public List<TicketSalesDTO> selectAll(Map<String, String> dates) throws ParseException {

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

    public Integer selectTotal(Map<String, String> dates) {
        Integer total = ticketSalesDAO.selectTotal(dates);
        if(total == null){
            return 0;
        }
        System.out.println("total : " + total);
        return total;
    }
}
