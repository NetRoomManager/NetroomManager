package com.itbank.repository.jpa;

import com.itbank.model.Product;
import com.itbank.model.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {
    Optional<Product> findByName(String name);

    Optional<List<Product>> findAllByProductCategory(ProductCategory productCategory);

}

