package com.itbank.service;

import com.itbank.model.Seat;
import com.itbank.repository.jpa.SeatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class SeatService {
    // @Service: 비즈니스 로직을 처리하는 서비스 계층의 컴포넌트에 사용
    // SeatService는 좌석 관련 비즈니스 로직을 처리. CRUD 기능을 제공하는 메소드를 구현
    // SeatRepository를 주입받아 데이터 액세스를 수행
    @Autowired
    private SeatRepository seatRepository;

    public void createSeat() {

        for(int i = 1; i <= 24; i ++){
            Seat seat = new Seat();
            seat.setSeatId((long)i);
            seat.setSeatIpAddr("192.168.112."+i);
            if(i % 2 == 0){
                seat.setSeatState(2L);
            }
            if(i == 5){
                seat.setSeatState(3L);
            }
            if(i == 8){
                seat.setSeatState(4L);
            }
            seatRepository.save(seat);
        }
    }

    public List<Seat> selectSeatList() {
        return seatRepository.findAll();
    }

}