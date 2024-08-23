package com.tienda.tienda.service;

import com.tienda.tienda.model.ProductoPromocion;
import com.tienda.tienda.repository.ProductoPromocionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
