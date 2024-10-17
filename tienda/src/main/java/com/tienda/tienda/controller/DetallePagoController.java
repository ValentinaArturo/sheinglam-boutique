package com.tienda.tienda.controller;

import com.tienda.tienda.model.DetallePago;
import com.tienda.tienda.service.DetallePagoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@CrossOrigin
@RestController
@RequestMapping("/api/detalles-pago")
public class DetallePagoController {

    @Autowired
    private DetallePagoService detallePagoService;

    @GetMapping
    public List<DetallePago> getAllDetallesPago() {
        return detallePagoService.getAllDetallesPago();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetallePago> getDetallePagoById(@PathVariable int id) {
        DetallePago detallePago = detallePagoService.getDetallePagoById(id);
        if (detallePago != null) {
            return ResponseEntity.ok(detallePago);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public DetallePago createDetallePago(@RequestBody DetallePago detallePago) {
        return detallePagoService.saveDetallePago(detallePago);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetallePago> updateDetallePago(@PathVariable int id, @RequestBody DetallePago detallePagoDetails) {
        DetallePago detallePago = detallePagoService.getDetallePagoById(id);
        if (detallePago != null) {
            detallePago.setPedido(detallePagoDetails.getPedido());
            detallePago.setMetodoPago(detallePagoDetails.getMetodoPago());
            detallePago.setMonto(detallePagoDetails.getMonto());
            detallePago.setFecha(detallePagoDetails.getFecha());
            return ResponseEntity.ok(detallePagoService.saveDetallePago(detallePago));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDetallePago(@PathVariable int id) {
        if (detallePagoService.getDetallePagoById(id) != null) {
            detallePagoService.deleteDetallePago(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
