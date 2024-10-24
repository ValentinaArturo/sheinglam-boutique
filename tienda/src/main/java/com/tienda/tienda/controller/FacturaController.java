package com.tienda.tienda.controller;

import com.tienda.tienda.model.Factura;
import com.tienda.tienda.service.FacturaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/facturas")
public class FacturaController {

    @Autowired
    private FacturaService facturaService;

    @GetMapping
    public List<Factura> getAllFacturas() {
        return facturaService.getAllFacturas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Factura> getFacturaById(@PathVariable int id) {
        Factura factura = facturaService.getFacturaById(id);
        if (factura != null) {
            return ResponseEntity.ok(factura);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Factura createFactura(@RequestBody Factura factura) {
        return facturaService.saveFactura(factura);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Factura> updateFactura(@PathVariable int id, @RequestBody Factura facturaDetails) {
        Factura factura = facturaService.getFacturaById(id);
        if (factura != null) {
            factura.setPedido(facturaDetails.getPedido());
            factura.setTotal(facturaDetails.getTotal());
            factura.setFecha(facturaDetails.getFecha());
            return ResponseEntity.ok(facturaService.saveFactura(factura));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFactura(@PathVariable int id) {
        if (facturaService.getFacturaById(id) != null) {
            facturaService.deleteFactura(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
