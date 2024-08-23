package com.tienda.tienda.service;

import com.tienda.tienda.model.MetodoPago;
import com.tienda.tienda.repository.MetodoPagoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MetodoPagoService {

    @Autowired
    private MetodoPagoRepository metodoPagoRepository;

    public List<MetodoPago> getAllMetodosPago() {
        return metodoPagoRepository.findAll();
    }

    public MetodoPago getMetodoPagoById(int id) {
        return metodoPagoRepository.findById(id).orElse(null);
    }

    public MetodoPago saveMetodoPago(MetodoPago metodoPago) {
        return metodoPagoRepository.save(metodoPago);
    }

    public void deleteMetodoPago(int id) {
        metodoPagoRepository.deleteById(id);
    }
}
