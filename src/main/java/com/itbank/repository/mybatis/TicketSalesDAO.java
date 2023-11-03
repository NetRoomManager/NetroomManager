package com.itbank.repository.mybatis;

import com.itbank.model.dto.TicketSalesDTO;
import org.springframework.stereotype.Repository;


import java.sql.Date;
import java.util.List;
import java.util.Map;

@Repository
public interface TicketSalesDAO {
    List<TicketSalesDTO> selectAll(Map<String, Date> dates);

    // 총 금액
    int selectTotal();
}
