package com.itbank.repository.mybatis;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

@Repository
public interface DropOutUserDAO {

    @Delete("delete drop_out_user where id=#{id}")
    int delete(Long id);
}
