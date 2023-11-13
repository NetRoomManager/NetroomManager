package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.sql.Date;
import java.util.List;

@Table(name="product")
@Entity    // 제품
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;	// 제품 아이디

    @ManyToOne
    @JoinColumn(name = "product_category_id")
    private ProductCategory productCategory;	// 상품 카테고리 아이디

    @OneToOne(mappedBy = "product")
    private OrderDetail orderDetail;

    @PreRemove
    private void preRemove() {
        if(orderDetail!=null) {
            orderDetail.setProduct(null);
        }
    }

    @Column(nullable = false)
    private String name; // 상품명

    @Column(nullable = false)
    private Integer price;   // 가격

    @Column(nullable = false)
    private Integer dcRate;   // 할인율

    @UpdateTimestamp
    private Date updatedAt;   // 수정일

    @Column(nullable = false)
    private String detail; // 제품 상세

    private String img; // 제품 이미지 파일

    private Integer count;  // 제품 수량
}

