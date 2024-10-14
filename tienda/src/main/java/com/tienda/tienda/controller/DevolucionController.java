package com.tienda.tienda.controller;

import com.tienda.tienda.model.Devolucion;
import com.tienda.tienda.service.DevolucionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/devoluciones")
public class DevolucionController {

    @Autowired
    private DevolucionService devolucionService;

    @GetMapping
    public List<Devolucion> getAllDevoluciones() {
        return devolucionService.getAllDevoluciones();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Devolucion> getDevolucionById(@PathVariable int id) {
        Devolucion devolucion = devolucionService.getDevolucionById(id);
        if (devolucion != null) {
            return ResponseEntity.ok(devolucion);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Devolucion createDevolucion(@RequestBody Devolucion devolucion) {
        return devolucionService.saveDevolucion(devolucion);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Devolucion> updateDevolucion(@PathVariable int id, @RequestBody Devolucion devolucionDetails) {
        Devolucion devolucion = devolucionService.getDevolucionById(id);
        if (devolucion != null) {
            devolucion.setPedido(devolucionDetails.getPedido());
            devolucion.setMotivo(devolucionDetails.getMotivo());
            devolucion.setFechaDevolucion(devolucionDetails.getFechaDevolucion());
            devolucion.setEstado(devolucionDetails.getEstado());
            return ResponseEntity.ok(devolucionService.saveDevolucion(devolucion));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDevolucion(@PathVariable int id) {
        if (devolucionService.getDevolucionById(id) != null) {
            devolucionService.deleteDevolucion(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
