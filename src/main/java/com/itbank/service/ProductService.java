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
        product.setName("사이다");
        product.setImg("20230921204024_akmu.webp");
        product.setDetail("시원한 사이다 255ml 캔");
        product.setCount(50);
        product.setPrice(1000);
        product.setDcRate(10);
        productRepository.save(product);

        Product product2 = new Product();
        product.setProductCategory(productCategory);
        product.setName("너구리");
        product.setImg("20230921204355_bts_e.png");
        product.setDetail("맛있다!");
        product.setCount(50);
        product.setPrice(100);
        product.setDcRate(0);
        productRepository.save(product2);
    }

    // 관리자
    public void addProduct() {

    }
}
