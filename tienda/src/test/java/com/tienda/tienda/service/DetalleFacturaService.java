package com.tienda.tienda.service;

import com.tienda.tienda.model.DetalleFactura;
import com.tienda.tienda.repository.DetalleFacturaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetalleFacturaService {

    @Autowired
    private DetalleFacturaRepository detalleFacturaRepository;

    public List<DetalleFactura> getAllDetallesFactura() {
        return detalleFacturaRepository.findAll();
    }

    public DetalleFactura getDetalleFacturaById(int id) {
        return detalleFacturaRepository.findById(id).orElse(null);
    }

    public DetalleFactura saveDetalleFactura(DetalleFactura detalleFactura) {
        return detalleFacturaRepository.save(detalleFactura);
    }

    public void deleteDetalleFactura(int id) {
        detalleFacturaRepository.deleteById(id);
    }
}
