package com.tienda.tienda.controller;

import com.tienda.tienda.model.ImagenProducto;
import com.tienda.tienda.service.ImagenProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/imagenes-producto")
public class ImagenProductoController {

    @Autowired
    private ImagenProductoService imagenProductoService;

    @GetMapping
    public List<ImagenProducto> getAllImagenesProducto() {
        return imagenProductoService.getAllImagenesProducto();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ImagenProducto> getImagenProductoById(@PathVariable int id) {
        ImagenProducto imagenProducto = imagenProductoService.getImagenProductoById(id);
        if (imagenProducto != null) {
            return ResponseEntity.ok(imagenProducto);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ImagenProducto createImagenProducto(@RequestBody ImagenProducto imagenProducto) {
        return imagenProductoService.saveImagenProducto(imagenProducto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ImagenProducto> updateImagenProducto(@PathVariable int id, @RequestBody ImagenProducto imagenProductoDetails) {
        ImagenProducto imagenProducto = imagenProductoService.getImagenProductoById(id);
        if (imagenProducto != null) {
            imagenProducto.setProducto(imagenProductoDetails.getProducto());
            imagenProducto.setImagenProducto(imagenProductoDetails.getImagenProducto());
            return ResponseEntity.ok(imagenProductoService.saveImagenProducto(imagenProducto));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteImagenProducto(@PathVariable int id) {
        if (imagenProductoService.getImagenProductoById(id) != null) {
            imagenProductoService.deleteImagenProducto(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
