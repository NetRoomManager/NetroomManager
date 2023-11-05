package com.itbank.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Message {

    private String from;
    private String message;
    private String to;

    @Override
    public String toString() {
        String msg = "";
        msg += "from: " + from + '\n';
        msg += "message: " + message + '\n';
        msg += "to: " + to + '\n';
        return msg;
    }
}
