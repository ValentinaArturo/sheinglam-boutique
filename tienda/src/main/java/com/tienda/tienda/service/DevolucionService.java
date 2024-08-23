package com.tienda.tienda.service;

import com.tienda.tienda.model.Devolucion;
import com.tienda.tienda.repository.DevolucionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DevolucionService {

    @Autowired
    private DevolucionRepository devolucionRepository;

    public List<Devolucion> getAllDevoluciones() {
        return devolucionRepository.findAll();
    }

    public Devolucion getDevolucionById(int id) {
        return devolucionRepository.findById(id).orElse(null);
    }

    public Devolucion saveDevolucion(Devolucion devolucion) {
        return devolucionRepository.save(devolucion);
    }

    public void deleteDevolucion(int id) {
        devolucionRepository.deleteById(id);
    }
}
