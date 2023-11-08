package com.itbank.repository.mybatis;

import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

@Repository
public interface DropOutUserDAO {

    @Insert("insert into drop_out_user(USER_ID, DROPAT) values(#{id}, sysdate)")
    int insert(long id);

}
