package com.itbank.service;

import com.itbank.component.FileComponent;
import com.itbank.model.Product;
import com.itbank.model.ProductCategory;
import com.itbank.model.ProductDTO;
import com.itbank.repository.jpa.ProductCategoryRepository;
import com.itbank.repository.jpa.ProductRepository;
import com.itbank.repository.mybatis.ProductCategoryDAO;
import com.itbank.repository.mybatis.ProductDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private ProductCategoryRepository productCategoryRepository;
    @Autowired
    private ProductCategoryDAO productCategoryDAO;

    @Autowired
    private FileComponent fileComponent;

//    public void addProduct(Product paramProduct, MultipartFile img) {
//        Product product = new Product();
//
//        if(!img.isEmpty()) {
//            String filePath = fileComponent.upload(img);
//
//            product.setImg(filePath);
//        }
//
//        product.setProductCategory(paramProduct.getProductCategory());
//        product.setName(paramProduct.getName());
//        product.setDetail(paramProduct.getDetail());
//        product.setCount(paramProduct.getCount());
//        product.setPrice(paramProduct.getPrice());
//        product.setDcRate(paramProduct.getDcRate());
//        productRepository.save(product);
//    }

    public int addProduct(ProductDTO dto) {
        int id = 0;
        if(!dto.getUpload().isEmpty()) {
            String fileName = fileComponent.upload(dto.getUpload());
            dto.setImg(fileName);
        }
        int row = productDAO.insertProduct(dto);
        if(row != 0) {
            id = productDAO.selectMaxId();
        }
        log.info(dto.getProductCategoryName());
        return id;
    }

    public int addProductCategory(ProductCategory paramProductCategory) {
        System.out.println("들어오는 지 확인"+paramProductCategory.getName());
        int id = 0;
        int row = productCategoryDAO.insetProductCategory(paramProductCategory);
        if(row != 0) {
            id = productCategoryDAO.selectMaxId(paramProductCategory);
        }
        return id;
    }

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

    public List<ProductDTO> selectAllProduct() {
        return productDAO.selectAll();
    }

    public List<ProductCategory> selectAllProductCategory() {
        return productCategoryDAO.selectAll();
    }

    public ProductDTO selectOne(int id) { return productDAO.selectOne(id); }

    public int deleteProduct(int id) {
        String fileName = productDAO.findFile(id);
        if(fileName != null) {
            fileComponent.deleteFile(fileName);
        }
        return productDAO.deleteProduct(id);
    }

    public int updateProduct(ProductDTO dto) {
        int id = 0;
        String fileName = productDAO.findFile(Math.toIntExact(dto.getId()));
        fileComponent.deleteFile(fileName);
        fileName = fileComponent.upload(dto.getUpload());
        dto.setImg(fileName);
        int row = productDAO.update(dto);
        return id;
    }
}
