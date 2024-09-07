package com.tienda.tienda.service;

import com.tienda.tienda.model.DetallePedido;
import com.tienda.tienda.repository.DetallePedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class DetallePedidoService {

    @Autowired
    private DetallePedidoRepository detallePedidoRepository;

    public List<DetallePedido> getAllDetallesPedido() {
        return detallePedidoRepository.findAll();
    }

    public DetallePedido getDetallePedidoById(int id) {
        return detallePedidoRepository.findById(id).orElse(null);
    }

    public DetallePedido saveDetallePedido(DetallePedido detallePedido) {
        return detallePedidoRepository.save(detallePedido);
    }

    public void deleteDetallePedido(int id) {
        detallePedidoRepository.deleteById(id);
    }
}
