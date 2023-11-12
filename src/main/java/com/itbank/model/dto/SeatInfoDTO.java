package com.itbank.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class SeatInfoDTO {
    private Long seatId;
    private String seatIpAddr;
    private Integer seatState;
    private Long user_id;
    private Long remainingTime;
    private String username;

}
