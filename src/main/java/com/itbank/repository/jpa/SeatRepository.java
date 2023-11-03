package com.itbank.repository.jpa;

import com.itbank.model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SeatRepository extends JpaRepository<Seat, Long> {
    // @Repository: 데이터 액세스 계층의 컴포넌트에 사용됩니다.
    Optional<Seat> findBySeatId(Seat seatId);

}
