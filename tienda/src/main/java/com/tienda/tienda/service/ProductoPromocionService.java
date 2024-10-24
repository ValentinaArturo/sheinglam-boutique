package com.tienda.tienda.service;

import com.tienda.tienda.model.ProductoPromocion;
import com.tienda.tienda.repository.ProductoPromocionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class ProductoPromocionService {

    @Autowired
    private ProductoPromocionRepository productoPromocionRepository;

    public List<ProductoPromocion> getAllProductoPromociones() {
        return productoPromocionRepository.findAll();
    }

    public ProductoPromocion getProductoPromocionById(int id) {
        return productoPromocionRepository.findById(id).orElse(null);
    }

    public ProductoPromocion saveProductoPromocion(ProductoPromocion productoPromocion) {
        return productoPromocionRepository.save(productoPromocion);
    }

    public void deleteProductoPromocion(int id) {
        productoPromocionRepository.deleteById(id);
    }
    
    public List<ProductoPromocion> getPromocionesByProductoId(int productoId) {
        return productoPromocionRepository.findByProducto_IdProducto(productoId);
    }
}
