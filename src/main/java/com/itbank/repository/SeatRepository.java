package com.itbank.repository;

import com.itbank.model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface SeatRepository extends JpaRepository<Seat, Long> {    // 데이터베이스와의 상호작용을 담당하는 레포지토리 클래스에 적용
    // @Repository: 데이터 액세스 계층의 컴포넌트에 사용됩니다.

    Optional<Seat> findBySeatId(Seat seatId);


}
