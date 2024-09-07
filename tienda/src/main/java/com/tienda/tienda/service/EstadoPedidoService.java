package com.tienda.tienda.service;

import com.tienda.tienda.model.EstadoPedido;
import com.tienda.tienda.repository.EstadoPedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@CrossOrigin
@Service
public class EstadoPedidoService {

    @Autowired
    private EstadoPedidoRepository estadoPedidoRepository;

    public List<EstadoPedido> getAllEstadosPedido() {
        return estadoPedidoRepository.findAll();
    }

    public EstadoPedido getEstadoPedidoById(int id) {
        return estadoPedidoRepository.findById(id).orElse(null);
    }

    public EstadoPedido saveEstadoPedido(EstadoPedido estadoPedido) {
        return estadoPedidoRepository.save(estadoPedido);
    }

    public void deleteEstadoPedido(int id) {
        estadoPedidoRepository.deleteById(id);
    }
}
