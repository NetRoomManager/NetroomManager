package com.itbank.repository.mybatis;

import com.itbank.model.ProductCategory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductCategoryDAO {

    List<ProductCategory> selectAll();

    int insetProductCategory(ProductCategory paramProductCategory);

    int selectMaxId(ProductCategory paramProductCategory);
}
