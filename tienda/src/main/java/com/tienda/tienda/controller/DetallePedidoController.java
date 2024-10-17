package com.tienda.tienda.controller;

import com.tienda.tienda.model.DetallePedido;
import com.tienda.tienda.service.DetallePedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/detalles-pedido")
public class DetallePedidoController {

    @Autowired
    private DetallePedidoService detallePedidoService;

    @GetMapping
    public List<DetallePedido> getAllDetallesPedido() {
        return detallePedidoService.getAllDetallesPedido();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetallePedido> getDetallePedidoById(@PathVariable int id) {
        DetallePedido detallePedido = detallePedidoService.getDetallePedidoById(id);
        if (detallePedido != null) {
            return ResponseEntity.ok(detallePedido);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public DetallePedido createDetallePedido(@RequestBody DetallePedido detallePedido) {
        return detallePedidoService.saveDetallePedido(detallePedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetallePedido> updateDetallePedido(@PathVariable int id, @RequestBody DetallePedido detallePedidoDetails) {
        DetallePedido detallePedido = detallePedidoService.getDetallePedidoById(id);
        if (detallePedido != null) {
            detallePedido.setPedido(detallePedidoDetails.getPedido());
            detallePedido.setProducto(detallePedidoDetails.getProducto());
            detallePedido.setCantidad(detallePedidoDetails.getCantidad());
            detallePedido.setPrecioUnitario(detallePedidoDetails.getPrecioUnitario());
            detallePedido.setSubtotal(detallePedidoDetails.getSubtotal());
            return ResponseEntity.ok(detallePedidoService.saveDetallePedido(detallePedido));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDetallePedido(@PathVariable int id) {
        if (detallePedidoService.getDetallePedidoById(id) != null) {
            detallePedidoService.deleteDetallePedido(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
