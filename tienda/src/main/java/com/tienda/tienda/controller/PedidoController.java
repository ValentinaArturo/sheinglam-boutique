package com.tienda.tienda.controller;

import com.tienda.tienda.model.Pedido;
import com.tienda.tienda.service.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/pedidos")
public class PedidoController {

    @Autowired
    private PedidoService pedidoService;

    @GetMapping
    public List<Pedido> getAllPedidos() {
        return pedidoService.getAllPedidos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pedido> getPedidoById(@PathVariable int id) {
        Pedido pedido = pedidoService.getPedidoById(id);
        if (pedido != null) {
            return ResponseEntity.ok(pedido);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Pedido createPedido(@RequestBody Pedido pedido) {
        return pedidoService.savePedido(pedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Pedido> updatePedido(@PathVariable int id, @RequestBody Pedido pedidoDetails) {
        Pedido pedido = pedidoService.getPedidoById(id);
        if (pedido != null) {
            pedido.setCliente(pedidoDetails.getCliente());
            pedido.setFecha(pedidoDetails.getFecha());
            pedido.setTotal(pedidoDetails.getTotal());
            pedido.setMetodoPago(pedidoDetails.getMetodoPago());
            pedido.setNit(pedidoDetails.getNit());
            return ResponseEntity.ok(pedidoService.savePedido(pedido));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePedido(@PathVariable int id) {
        if (pedidoService.getPedidoById(id) != null) {
            pedidoService.deletePedido(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
