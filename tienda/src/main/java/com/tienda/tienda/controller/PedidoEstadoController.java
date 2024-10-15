package com.tienda.tienda.controller;

import com.tienda.tienda.model.PedidoEstado;
import com.tienda.tienda.service.PedidoEstadoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*") 
@RequestMapping("/api/pedidos-estados")
public class PedidoEstadoController {

    @Autowired
    private PedidoEstadoService pedidoEstadoService;

    @GetMapping
    public List<PedidoEstado> getAllEstadosPedido() {
        return pedidoEstadoService.getAllEstadosPedido();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PedidoEstado> getPedidoEstadoById(@PathVariable int id) {
        PedidoEstado pedidoEstado = pedidoEstadoService.getEstadoPedidoById(id);
        if (pedidoEstado != null) {
            return ResponseEntity.ok(pedidoEstado);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public PedidoEstado createPedidoEstado(@RequestBody PedidoEstado pedidoEstado) {
        return pedidoEstadoService.saveEstadoPedido(pedidoEstado);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PedidoEstado> updatePedidoEstado(@PathVariable int id, @RequestBody PedidoEstado pedidoEstadoDetails) {
        PedidoEstado pedidoEstado = pedidoEstadoService.getEstadoPedidoById(id);
        if (pedidoEstado != null) {
            pedidoEstado.setPedido(pedidoEstadoDetails.getPedido());
            pedidoEstado.setEstadoPedido(pedidoEstadoDetails.getEstadoPedido());
            pedidoEstado.setFecha(pedidoEstadoDetails.getFecha());
            return ResponseEntity.ok(pedidoEstadoService.saveEstadoPedido(pedidoEstado));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePedidoEstado(@PathVariable int id) {
        if (pedidoEstadoService.getEstadoPedidoById(id) != null) {
            pedidoEstadoService.deleteEstadoPedido(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
