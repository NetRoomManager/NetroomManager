package com.itbank.service;

import com.itbank.component.MaileComponent;
import com.itbank.model.User;
import com.itbank.repository.jpa.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;

@Service
@Slf4j
public class AuthService {

    @Autowired
    private MaileComponent maileComponent;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

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

    // 사용자의 이름과, 이메일을 받고 성공했으면 1을 반환, 아니면 0을 반환한다
    public String findUserId(User user) {
        Optional<User> userOptional =  userRepository.findByNameAndEmail(user.getName(), user.getEmail());
        log.info(userOptional.get().getUsername());
        HashMap<String, String> param = new HashMap<>();

        param.put("receiver", user.getEmail());
        param.put("subject", "[NetroomManager] 아이디 입니다");
        param.put("content", String.valueOf(user.getId()));

        String userId = userOptional.get().getUsername();
        int i = maileComponent.findUserId(param, userId);
        // 성공했으면
        if (i == 1){
            String successId = "<script>alert('성공'); window.location='/auth/login';</script>";
            return successId;
        }else{// 실패
            String failId = "<script>alert('실패'); window.location='/auth/login';</script>";
            return failId;
        }
    }

    // id(Username)랑 이메일이 일치하면 UUID로 8글자의 랜덤 비밀번호 만들기
    public String findUserPw(User user) {
        Optional<User> userOptional = userRepository.findByUsernameAndEmail(user.getUsername(), user.getEmail());
        if (userOptional.isPresent()) {
            String newPassword = UUID.randomUUID().toString().substring(0, 8);
            String encodedPassword = passwordEncoder.encode(newPassword);

            userOptional.get().setPassword(encodedPassword);
            userRepository.save(userOptional.get());

            HashMap<String, String> param = new HashMap<>();
            param.put("receiver", user.getEmail());
            param.put("subject", "[NetRoomManager] 임시 비밀번호 입니다");
            param.put("content", newPassword);

            int result = maileComponent.sendPw(param);

            if (result == 1) { // UUID 비밀번호 전송 성공시
                String successPw = "<script>alert('성공'); window.location='/auth/login';</script>";
                return successPw;
            } else {    // UUID 비밀번호 전송 실패시
                String failPw = "<script>alert('실패'); window.location='/auth/login';</script>";
                return failPw;
            }
        }
        String known = "<script>alert('회원 정보 불일치'); window.location='/auth/login';</script>";
        return known;
    }
}
