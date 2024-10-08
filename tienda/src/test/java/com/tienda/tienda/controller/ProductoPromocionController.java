package com.tienda.tienda.controller;

import com.tienda.tienda.model.ProductoPromocion;
import com.tienda.tienda.service.ProductoPromocionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/productos-promociones")
public class ProductoPromocionController {

    @Autowired
    private ProductoPromocionService productoPromocionService;

    @GetMapping
    public List<ProductoPromocion> getAllProductoPromociones() {
        return productoPromocionService.getAllProductoPromociones();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductoPromocion> getProductoPromocionById(@PathVariable int id) {
        ProductoPromocion productoPromocion = productoPromocionService.getProductoPromocionById(id);
        if (productoPromocion != null) {
            return ResponseEntity.ok(productoPromocion);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ProductoPromocion createProductoPromocion(@RequestBody ProductoPromocion productoPromocion) {
        return productoPromocionService.saveProductoPromocion(productoPromocion);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductoPromocion> updateProductoPromocion(@PathVariable int id, @RequestBody ProductoPromocion productoPromocionDetails) {
        ProductoPromocion productoPromocion = productoPromocionService.getProductoPromocionById(id);
        if (productoPromocion != null) {
            productoPromocion.setProducto(productoPromocionDetails.getProducto());
            productoPromocion.setPromocion(productoPromocionDetails.getPromocion());
            return ResponseEntity.ok(productoPromocionService.saveProductoPromocion(productoPromocion));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProductoPromocion(@PathVariable int id) {
        if (productoPromocionService.getProductoPromocionById(id) != null) {
            productoPromocionService.deleteProductoPromocion(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
