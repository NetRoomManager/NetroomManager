package com.itbank.service;

import com.itbank.model.User;
import com.itbank.model.UserAndLastLog;
import com.itbank.model.UserLog;
import com.itbank.repository.UserLogRepository;
import com.itbank.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
public class UserLogService {

    @Autowired
    private UserLogRepository userLogRepository;

    @Autowired
    private UserRepository userRepository;

    public UserLog save(UserLog userLog) {
        return userLogRepository.save(userLog);
    }

    public Optional<UserLog> findLatestByUser(User user) {
        Pageable pageable = PageRequest.of(0, 1, Sort.Direction.DESC, "id");
        Page<UserLog> userLogs = userLogRepository.findLatestByUser(user, pageable);
        return userLogs.getContent().stream().findFirst();
    }

}
