package com.itbank.model;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Table(name="product_category")
@Entity    // 제품
@Getter
@Setter
public class ProductCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 일대다 관계 설정. mappedBy 속성에는 연관관계의 주인 필드 이름을 지정.
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Product> products; // 카테고리에 속함 상품들

}

