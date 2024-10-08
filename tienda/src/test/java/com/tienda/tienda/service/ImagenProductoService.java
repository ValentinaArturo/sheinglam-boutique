package com.tienda.tienda.service;

import com.tienda.tienda.model.ImagenProducto;
import com.tienda.tienda.repository.ImagenProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ImagenProductoService {

    @Autowired
    private ImagenProductoRepository imagenProductoRepository;

    public List<ImagenProducto> getAllImagenesProducto() {
        return imagenProductoRepository.findAll();
    }

    public ImagenProducto getImagenProductoById(int id) {
        return imagenProductoRepository.findById(id).orElse(null);
    }

    public ImagenProducto saveImagenProducto(ImagenProducto imagenProducto) {
        return imagenProductoRepository.save(imagenProducto);
    }

    public void deleteImagenProducto(int id) {
        imagenProductoRepository.deleteById(id);
    }
}
