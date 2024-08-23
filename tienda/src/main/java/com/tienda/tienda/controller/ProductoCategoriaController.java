package com.tienda.tienda.controller;

import com.tienda.tienda.model.ProductoCategoria;
import com.tienda.tienda.service.ProductoCategoriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/productos-categorias")
public class ProductoCategoriaController {

    @Autowired
    private ProductoCategoriaService productoCategoriaService;

    @GetMapping
    public List<ProductoCategoria> getAllProductoCategorias() {
        return productoCategoriaService.getAllProductoCategorias();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductoCategoria> getProductoCategoriaById(@PathVariable int id) {
        ProductoCategoria productoCategoria = productoCategoriaService.getProductoCategoriaById(id);
        if (productoCategoria != null) {
            return ResponseEntity.ok(productoCategoria);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ProductoCategoria createProductoCategoria(@RequestBody ProductoCategoria productoCategoria) {
        return productoCategoriaService.saveProductoCategoria(productoCategoria);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductoCategoria> updateProductoCategoria(@PathVariable int id, @RequestBody ProductoCategoria productoCategoriaDetails) {
        ProductoCategoria productoCategoria = productoCategoriaService.getProductoCategoriaById(id);
        if (productoCategoria != null) {
            productoCategoria.setProducto(productoCategoriaDetails.getProducto());
            productoCategoria.setCategoria(productoCategoriaDetails.getCategoria());
            return ResponseEntity.ok(productoCategoriaService.saveProductoCategoria(productoCategoria));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProductoCategoria(@PathVariable int id) {
        if (productoCategoriaService.getProductoCategoriaById(id) != null) {
            productoCategoriaService.deleteProductoCategoria(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
