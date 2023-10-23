package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.sql.Date;

@Table(name="product")
@Entity    // 제품
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productId;	// 제품 아이디


    @ManyToOne
    @JoinColumn(name = "productCateId")
    private ProductCategory productCateId;	// 상품 카테고리 아이디



    @Column(nullable = false)
    private String productName; // 상품명

    @Column(nullable = false)
    private Integer price;   // 가격

    @Column(nullable = false)
    private Integer dcRate;   // 할인율

    @UpdateTimestamp
    private Date updatedAt;   // 수정일

    @Column(nullable = false)
    private String detail; // 제품 상세

    private String img; // 제품 이미지 파일

    private Integer count;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productCategoryId")
    private ProductCategory category;
}

