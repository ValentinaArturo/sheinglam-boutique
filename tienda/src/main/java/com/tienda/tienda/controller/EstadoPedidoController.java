package com.tienda.tienda.controller;

import com.tienda.tienda.model.EstadoPedido;
import com.tienda.tienda.service.EstadoPedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/estados-pedido")
public class EstadoPedidoController {

    @Autowired
    private EstadoPedidoService estadoPedidoService;

    @GetMapping
    public List<EstadoPedido> getAllEstadosPedido() {
        return estadoPedidoService.getAllEstadosPedido();
    }

    @GetMapping("/{id}")
    public ResponseEntity<EstadoPedido> getEstadoPedidoById(@PathVariable int id) {
        EstadoPedido estadoPedido = estadoPedidoService.getEstadoPedidoById(id);
        if (estadoPedido != null) {
            return ResponseEntity.ok(estadoPedido);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public EstadoPedido createEstadoPedido(@RequestBody EstadoPedido estadoPedido) {
        return estadoPedidoService.saveEstadoPedido(estadoPedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<EstadoPedido> updateEstadoPedido(@PathVariable int id, @RequestBody EstadoPedido estadoPedidoDetails) {
        EstadoPedido estadoPedido = estadoPedidoService.getEstadoPedidoById(id);
        if (estadoPedido != null) {
            estadoPedido.setNombre(estadoPedidoDetails.getNombre());
            return ResponseEntity.ok(estadoPedidoService.saveEstadoPedido(estadoPedido));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEstadoPedido(@PathVariable int id) {
        if (estadoPedidoService.getEstadoPedidoById(id) != null) {
            estadoPedidoService.deleteEstadoPedido(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
