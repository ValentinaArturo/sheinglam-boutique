package com.tienda.tienda.service;

import com.tienda.tienda.model.MovimientoInventario;
import com.tienda.tienda.repository.MovimientoInventarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class MovimientoInventarioService {

    @Autowired
    private MovimientoInventarioRepository movimientoInventarioRepository;

    public List<MovimientoInventario> getAllMovimientosInventario() {
        return movimientoInventarioRepository.findAll();
    }

    public MovimientoInventario getMovimientoInventarioById(int id) {
        return movimientoInventarioRepository.findById(id).orElse(null);
    }

    public MovimientoInventario saveMovimientoInventario(MovimientoInventario movimientoInventario) {
        return movimientoInventarioRepository.save(movimientoInventario);
    }

    public void deleteMovimientoInventario(int id) {
        movimientoInventarioRepository.deleteById(id);
    }
}
