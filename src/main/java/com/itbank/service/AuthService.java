package com.itbank.service;

import com.itbank.component.MaileComponent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Random;

@Service
@Slf4j
public class AuthService {

    @Autowired
    private MaileComponent maileComponent;

    private Random ran = new Random();

    public HashMap<String, Integer> sendAuthNumber(String email, HttpSession session) {
        String authNumber = (ran.nextInt(899999) + 100000) + "";

        HashMap<String, String> param = new HashMap<>();
        param.put("receiver", email);
        param.put("subject", "[NetroomManger] 인증번호 입니다");
        param.put("content", authNumber);

        int row = maileComponent.sendMimeMessage(param);
        HashMap<String, Integer> authHash = new HashMap<>();
        log.info("row : " + row);
        log.info("authNumber : " + row);
        authHash.put("row",row);
        authHash.put("authNumber", Integer.valueOf(authNumber));
        return authHash;
    }


    public boolean checkAuthNumber(int authNumber, HttpSession session) {
        int sessionNumber = (int) session.getAttribute("authNumber");
        log.info("int sessionNumber : " + sessionNumber);
        System.out.println("sessionNumber =" + sessionNumber  + "   /authNumber ="  +  authNumber);
        return sessionNumber == authNumber;
    }
}
