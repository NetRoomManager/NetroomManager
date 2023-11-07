package com.itbank.repository.mybatis;

import com.itbank.model.Product;
import com.itbank.model.ProductDTO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDAO {
    List<ProductDTO> selectAll();

    int insertProduct(ProductDTO dto);

    int selectMaxId();

    List<Product> selectByCategoryId(Long id);
}
