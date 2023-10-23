package com.itbank.repository;

import com.itbank.model.DropOutUser;
import com.itbank.model.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductCategoryRepository  extends  JpaRepository<ProductCategory, Long> {
}


