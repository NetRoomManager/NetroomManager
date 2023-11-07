package com.itbank.repository.mybatis;

import com.itbank.model.dto.SeatInfoDTO;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
@Repository
public interface SeatDAO {
    List<SeatInfoDTO> getSeatInfoList();

    int updateSeatState(@Param("updateSeat") HashMap<String, Object> updateSeat);

    int updateSeatHour(@Param("updateSeat") HashMap<String, Object> updateSeat);
}
