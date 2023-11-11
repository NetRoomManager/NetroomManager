package com.itbank.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Message {

    private String from;
    private String message;
    private String to;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date time;

    @Override
    public String toString() {
        String msg = "\n";
        msg += "from: " + from + '\n';
        msg += "message: " + message + '\n';
        msg += "to: " + to + '\n';
        msg += "time: " + time + '\n' + '\n';
        return msg;
    }
}
