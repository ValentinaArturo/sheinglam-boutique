package com.tienda.tienda.controller;

import com.tienda.tienda.model.MetodoPago;
import com.tienda.tienda.service.MetodoPagoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/metodos-pago")
public class MetodoPagoController {

    @Autowired
    private MetodoPagoService metodoPagoService;

    @GetMapping
    public List<MetodoPago> getAllMetodosPago() {
        return metodoPagoService.getAllMetodosPago();
    }

    @GetMapping("/{id}")
    public ResponseEntity<MetodoPago> getMetodoPagoById(@PathVariable int id) {
        MetodoPago metodoPago = metodoPagoService.getMetodoPagoById(id);
        if (metodoPago != null) {
            return ResponseEntity.ok(metodoPago);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public MetodoPago createMetodoPago(@RequestBody MetodoPago metodoPago) {
        return metodoPagoService.saveMetodoPago(metodoPago);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MetodoPago> updateMetodoPago(@PathVariable int id, @RequestBody MetodoPago metodoPagoDetails) {
        MetodoPago metodoPago = metodoPagoService.getMetodoPagoById(id);
        if (metodoPago != null) {
            metodoPago.setNombre(metodoPagoDetails.getNombre());
            return ResponseEntity.ok(metodoPagoService.saveMetodoPago(metodoPago));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMetodoPago(@PathVariable int id) {
        if (metodoPagoService.getMetodoPagoById(id) != null) {
            metodoPagoService.deleteMetodoPago(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
