package com.itbank.model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;

@Getter
@Setter
public class ProductDTO {
    private Long id;
    private Long productCategoryId;
    private String name;
    private Integer price;
    private Integer dcRate;
    private Date updateAt;
    private String detail;
    private String img;
    private Integer count;
    private MultipartFile upload;
    private String productCategoryName;
    @Override
    public String toString() {
        return "ProductDTO{" +
                "id=" + id +
                ", productCategoryId=" + productCategoryId +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", dcRate=" + dcRate +
                ", updateAt=" + updateAt +
                ", detail='" + detail + '\'' +
                ", img='" + img + '\'' +
                ", count=" + count +
                ", productCategoryName='" + productCategoryName + '\'' +
                '}';
    }
}
