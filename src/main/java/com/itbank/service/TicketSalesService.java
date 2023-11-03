package com.itbank.service;

import com.itbank.model.TicketSales;
import com.itbank.model.dto.TicketSalesDTO;
import com.itbank.repository.jpa.TicketSalesRepository;
import com.itbank.repository.mybatis.TicketSalesDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class TicketSalesService {
    @Autowired
    private TicketSalesDAO ticketSalesDAO;

    public List<TicketSalesDTO> selectAll(HttpServletRequest request) throws ParseException {

        Map<String,Date> dates = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String startParam = request.getParameter("startDate");
        String endParam = request.getParameter("endDate");


        if(startParam == null || startParam.isEmpty()){
            log.info("1번째 분기문 들어옴: " + request.getParameter("startDate"));
            java.util.Date start  = sdf.parse("1970-01-01");
            Date startDate = new Date(start.getTime());
            log.info("startParam:"+startDate.toString());
            dates.put("startDate",startDate);
        }else{
            dates.put("startDate",new Date(sdf.parse(startParam).getTime()));
        }

        if(startParam == null || startParam.isEmpty()){
            log.info("2번째 분기문 들어옴");
            Date endDate = new Date(new java.util.Date().getTime());
            log.info("endDate:"+endDate.toString());
            dates.put("endDate",endDate);
        }else{
            dates.put("endDate",new Date(sdf.parse(endParam).getTime()));
        }


        log.info(dates.get("startDate").toString());
        log.info(dates.get("endDate").toString());

        return ticketSalesDAO.selectAll(dates);
    }

    //    public List<TicketSalesDTO> selectAll(HttpServletRequest request) {
//        Map<String,String> dates = new HashMap<>();
//        System.out.println(request.getParameter("startDate"));
//
//        dates.put("startDate", request.getParameter("startDate"));
//        dates.put("endDate", request.getParameter("endDate"));
//
//
//        return list;
//    }

    public int selectTotal() {
        int total = ticketSalesDAO.selectTotal();
        System.out.println("total : "+total);
        return total;
    }
}
