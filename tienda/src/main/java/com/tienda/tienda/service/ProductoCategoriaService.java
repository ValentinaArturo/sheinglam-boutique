package com.tienda.tienda.service;

import com.tienda.tienda.model.ProductoCategoria;
import com.tienda.tienda.repository.ProductoCategoriaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class ProductoCategoriaService {

    @Autowired
    private ProductoCategoriaRepository productoCategoriaRepository;

    public List<ProductoCategoria> getAllProductoCategorias() {
        return productoCategoriaRepository.findAll();
    }

    public ProductoCategoria getProductoCategoriaById(int id) {
        return productoCategoriaRepository.findById(id).orElse(null);
    }

    public ProductoCategoria saveProductoCategoria(ProductoCategoria productoCategoria) {
        return productoCategoriaRepository.save(productoCategoria);
    }

    public void deleteProductoCategoria(int id) {
        productoCategoriaRepository.deleteById(id);
    }
}
