package com.tienda.tienda.service;

import com.tienda.tienda.model.Carrito;
import com.tienda.tienda.repository.CarritoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CarritoService {

    @Autowired
    private CarritoRepository carritoRepository;

    public List<Carrito> getAllCarritos() {
        return carritoRepository.findAll();
    }

    public Carrito getCarritoById(int id) {
        return carritoRepository.findById(id).orElse(null);
    }

    public Carrito saveCarrito(Carrito carrito) {
        return carritoRepository.save(carrito);
    }

    public void deleteCarrito(int id) {
        carritoRepository.deleteById(id);
    }
}
