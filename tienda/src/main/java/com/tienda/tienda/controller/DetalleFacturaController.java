package com.tienda.tienda.controller;

import com.tienda.tienda.model.DetalleFactura;
import com.tienda.tienda.service.DetalleFacturaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/detalles-factura")
public class DetalleFacturaController {

    @Autowired
    private DetalleFacturaService detalleFacturaService;

    @GetMapping
    public List<DetalleFactura> getAllDetallesFactura() {
        return detalleFacturaService.getAllDetallesFactura();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetalleFactura> getDetalleFacturaById(@PathVariable int id) {
        DetalleFactura detalleFactura = detalleFacturaService.getDetalleFacturaById(id);
        if (detalleFactura != null) {
            return ResponseEntity.ok(detalleFactura);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public DetalleFactura createDetalleFactura(@RequestBody DetalleFactura detalleFactura) {
        return detalleFacturaService.saveDetalleFactura(detalleFactura);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DetalleFactura> updateDetalleFactura(@PathVariable int id, @RequestBody DetalleFactura detalleFacturaDetails) {
        DetalleFactura detalleFactura = detalleFacturaService.getDetalleFacturaById(id);
        if (detalleFactura != null) {
            detalleFactura.setFactura(detalleFacturaDetails.getFactura());
            detalleFactura.setProducto(detalleFacturaDetails.getProducto());
            detalleFactura.setCantidad(detalleFacturaDetails.getCantidad());
            detalleFactura.setPrecioUnitario(detalleFacturaDetails.getPrecioUnitario());
            detalleFactura.setSubtotal(detalleFacturaDetails.getSubtotal());
            return ResponseEntity.ok(detalleFacturaService.saveDetalleFactura(detalleFactura));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDetalleFactura(@PathVariable int id) {
        if (detalleFacturaService.getDetalleFacturaById(id) != null) {
            detalleFacturaService.deleteDetalleFactura(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
