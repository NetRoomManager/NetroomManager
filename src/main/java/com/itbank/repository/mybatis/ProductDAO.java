package com.itbank.repository.mybatis;

import com.itbank.model.Product;
import com.itbank.model.ProductDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

@Repository
public interface ProductDAO {
    List<ProductDTO> selectAll();

    int insertProduct(ProductDTO dto);

    int selectMaxId();

    List<Product> selectByCategoryId(Long id);

    ProductDTO selectOne(int id);

    int deleteProduct(int id);

    String findFile(int id);

    int update(ProductDTO dto);


}
