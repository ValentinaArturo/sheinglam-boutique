package com.tienda.tienda.service;

import com.tienda.tienda.model.CarritoProducto;
import com.tienda.tienda.repository.CarritoProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class CarritoProductoService {

    @Autowired
    private CarritoProductoRepository carritoProductoRepository;

    public List<CarritoProducto> getAllCarritoProductos() {
        return carritoProductoRepository.findAll();
    }

    public CarritoProducto getCarritoProductoById(int id) {
        return carritoProductoRepository.findById(id).orElse(null);
    }

    public CarritoProducto saveCarritoProducto(CarritoProducto carritoProducto) {
        return carritoProductoRepository.save(carritoProducto);
    }

    public void deleteCarritoProducto(int id) {
        carritoProductoRepository.deleteById(id);
    }
}
