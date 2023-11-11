package com.itbank.service;

import com.itbank.model.RemainingTime;
import com.itbank.model.Seat;
import com.itbank.model.dto.SeatInfoDTO;
import com.itbank.repository.jpa.RemainingTimeRepository;
import com.itbank.repository.jpa.SeatRepository;
import com.itbank.repository.jpa.UserRepository;
import com.itbank.repository.mybatis.SeatDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class SeatService {
    // @Service: 비즈니스 로직을 처리하는 서비스 계층의 컴포넌트에 사용
    // SeatService는 좌석 관련 비즈니스 로직을 처리. CRUD 기능을 제공하는 메소드를 구현
    // SeatRepository를 주입받아 데이터 액세스를 수행
    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private RemainingTimeRepository remainingTimeRepository;

    @Autowired
    private SeatDAO seatDAO;

    @Autowired
    private UserRepository userRepository;

    public SeatService(SeatDAO seatDAO) {
        this.seatDAO = seatDAO;
    }

    public void createSeat() {

        String[] addList = {
                "192.168.112.15",
                "192.168.112.31",
                "192.168.112.24",
                "192.168.112.22",
                "192.168.112.18",
                "192.168.112.17",
                "192.168.112.33",
                "192.168.112.32",
                "192.168.112.25",
                "192.168.112.9",
                "192.168.112.37",
                "192.168.112.13",
                "192.168.112.30",
                "192.168.112.23",
                "192.168.112.11",
                "192.168.112.14",
                "192.168.112.21",
                "192.168.112.19",
                "192.168.112.20",
                "192.168.112.10",
                "192.168.112.36",
                "192.168.112.12",
                "192.168.112.16",
                "192.168.112.35"
        };

        for(int i=0;i<addList.length;i++){
            Seat seat = new Seat();
            seat.setSeatId((long)(i+1));
            seat.setSeatIpAddr(addList[i]);
            seatRepository.save(seat);
        }

    }

    public List<SeatInfoDTO> selectSeatList() {
         System.out.println("service selectSeatList =" + seatDAO.getSeatInfoList());
        List<SeatInfoDTO> List = seatDAO.getSeatInfoList();
        for(SeatInfoDTO seat : List){
            if(seat.getUser_id() != null){
                seat.setSeatState(2);
                HashMap<String , Object> map = new HashMap<>();
                map.put("seatId",seat.getSeatId());
                map.put("seatState",seat.getSeatState());
                seatDAO.updateSeatState(map);
            }
        }
        return seatDAO.getSeatInfoList();
    }

    public int updateSeat(Long state, Integer hour, Long seatId) {
        System.out.println("updateSeat  ");
        HashMap<String, Object> updateSeat = new HashMap<>();
        updateSeat.put("seatId",seatId);
        updateSeat.put("seatState",state);
        Optional<Seat> seat = seatRepository.findById(seatId);
        System.out.println("seatId  : " + updateSeat.get("seatId"));
        System.out.println("seatState  : " + updateSeat.get("seatState"));
        System.out.println("seat  : " +seat.isPresent());

        int i = 0;

        if(seat.isPresent() && hour > 0 && seat.get().getUser() != null ){    // 시간추가
            log.info( "updateSeatHour state" + state);

            updateSeat.put("hour",hour);
            log.info( "updateSeatHour addHour" + hour);
            i = seatDAO.updateSeatHour(updateSeat);
            log.info( "updateSeatHour i" + i);
        }


        return i;
    }

    public int updateState(Long seatId, Long state) {
        HashMap<String, Object> updateSeat = new HashMap<>();
        updateSeat.put("seatId",seatId);
        updateSeat.put("seatState",state);
        Optional<Seat> seat = seatRepository.findById(seatId);
        int i = 0;
        if(seat.isPresent() && seat.get().getUser() == null ){
            log.info( "updateSeatState state" + state);
            i = seatDAO.updateSeatState(updateSeat);
            log.info( "updateSeatState i" + i);
        }
        return i;
    }


}