package com.itbank.service;

import com.itbank.model.RemainingTime;
import com.itbank.model.Seat;
import com.itbank.model.dto.SeatInfoDTO;
import com.itbank.repository.jpa.RemainingTimeRepository;
import com.itbank.repository.jpa.SeatRepository;
import com.itbank.repository.mybatis.SeatDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;

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

    public SeatService(SeatDAO seatDAO) {
        this.seatDAO = seatDAO;
    }

    public void createSeat() {

        for(int i = 1; i <= 24; i ++){
            Seat seat = new Seat();
            seat.setSeatId((long)i);
            seat.setSeatIpAddr("192.168.112."+i);

            if(seat.getSeatId()==1){
                seat.setSeatIpAddr("192.168.112.15");
            }
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
            Long addHour = 60L;
            switch (hour) {
                case 1:
                    addHour = 60L;
                    break;
                case 2:
                    addHour = 120L;
                    break;
                case 3:
                    addHour = 180L;
                    break;
                case 4:
                    addHour = 240L;
                    break;
                case 5:
                    addHour = 300L;
                    break;
                case 6:
                    addHour = 360L;
                    break;
                default:
                    addHour = 0L;
                    break;
            }
            updateSeat.put("addHour",addHour);
            log.info( "updateSeatHour addHour" + addHour);
            i = seatDAO.updateSeatHour(updateSeat);
            log.info( "updateSeatHour i" + i);
        }
        if(seat.isPresent() && seat.get().getUser() == null ){
            log.info( "updateSeatState state" + state);
            i = seatDAO.updateSeatState(updateSeat);
            log.info( "updateSeatState i" + i);
        }

        else {
            log.info( "업데이트 실패" );
        }

        return i;
    }


}