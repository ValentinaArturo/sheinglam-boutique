package com.tienda.tienda.controller;

import com.tienda.tienda.model.CarritoProducto;
import com.tienda.tienda.service.CarritoProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/carrito-productos")
public class CarritoProductoController {

    @Autowired
    private CarritoProductoService carritoProductoService;

    @GetMapping
    public List<CarritoProducto> getAllCarritoProductos() {
        return carritoProductoService.getAllCarritoProductos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<CarritoProducto> getCarritoProductoById(@PathVariable int id) {
        CarritoProducto carritoProducto = carritoProductoService.getCarritoProductoById(id);
        if (carritoProducto != null) {
            return ResponseEntity.ok(carritoProducto);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public CarritoProducto createCarritoProducto(@RequestBody CarritoProducto carritoProducto) {
        return carritoProductoService.saveCarritoProducto(carritoProducto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CarritoProducto> updateCarritoProducto(@PathVariable int id, @RequestBody CarritoProducto carritoProductoDetails) {
        CarritoProducto carritoProducto = carritoProductoService.getCarritoProductoById(id);
        if (carritoProducto != null) {
            carritoProducto.setCarrito(carritoProductoDetails.getCarrito());
            carritoProducto.setProducto(carritoProductoDetails.getProducto());
            carritoProducto.setCantidad(carritoProductoDetails.getCantidad());
            return ResponseEntity.ok(carritoProductoService.saveCarritoProducto(carritoProducto));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCarritoProducto(@PathVariable int id) {
        if (carritoProductoService.getCarritoProductoById(id) != null) {
            carritoProductoService.deleteCarritoProducto(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
