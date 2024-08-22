package com.tienda.tienda.service;

import com.tienda.tienda.model.DetallePago;
import com.tienda.tienda.repository.DetallePagoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetallePagoService {

    @Autowired
    private DetallePagoRepository detallePagoRepository;

    public List<DetallePago> getAllDetallesPago() {
        return detallePagoRepository.findAll();
    }

    public DetallePago getDetallePagoById(int id) {
        return detallePagoRepository.findById(id).orElse(null);
    }

    public DetallePago saveDetallePago(DetallePago detallePago) {
        return detallePagoRepository.save(detallePago);
    }

    public void deleteDetallePago(int id) {
        detallePagoRepository.deleteById(id);
    }
}
