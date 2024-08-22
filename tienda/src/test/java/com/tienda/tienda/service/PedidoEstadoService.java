package com.tienda.tienda.service;

import com.tienda.tienda.model.PedidoEstado;
import com.tienda.tienda.repository.PedidoEstadoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PedidoEstadoService {

    @Autowired
    private PedidoEstadoRepository pedidoEstadoRepository;

    public List<PedidoEstado> getAllEstadosPedido() {
        return pedidoEstadoRepository.findAll();
    }

    public PedidoEstado getEstadoPedidoById(int id) {
        return pedidoEstadoRepository.findById(id).orElse(null);
    }

    public PedidoEstado saveEstadoPedido(PedidoEstado pedidoEstado) {
        return pedidoEstadoRepository.save(pedidoEstado);
    }

    public void deleteEstadoPedido(int id) {
        pedidoEstadoRepository.deleteById(id);
    }
}
