package com.itbank.service;

import com.itbank.model.Product;
import com.itbank.model.ProductCategory;
import com.itbank.repository.ProductCategoryRepository;
import com.itbank.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductCategoryRepository productCategoryRepository;

    public void createProduct() {

        ProductCategory productCategory = new ProductCategory();
        productCategory.setName("테스트");
        productCategoryRepository.save(productCategory);

        Product product = new Product();
        product.setProductCategory(productCategory);
        product.setName("제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발제발");
        product.setImg("test");
        product.setDetail("test");
        product.setCount(1);
        product.setPrice(12345);
        product.setDcRate(0);
        productRepository.save(product);

    }

    // 관리자
    public void addProduct() {

    }
}
