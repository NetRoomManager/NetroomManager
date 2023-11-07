package com.itbank.repository.jpa;

import com.itbank.model.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Long> {
    @Override
    Optional<ProductCategory> findById(Long id);
}

