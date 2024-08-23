package com.tienda.tienda.controller;

import com.tienda.tienda.model.MovimientoInventario;
import com.tienda.tienda.service.MovimientoInventarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/movimientos-inventario")
public class MovimientoInventarioController {

    @Autowired
    private MovimientoInventarioService movimientoInventarioService;

    @GetMapping
    public List<MovimientoInventario> getAllMovimientosInventario() {
        return movimientoInventarioService.getAllMovimientosInventario();
    }

    @GetMapping("/{id}")
    public ResponseEntity<MovimientoInventario> getMovimientoInventarioById(@PathVariable int id) {
        MovimientoInventario movimientoInventario = movimientoInventarioService.getMovimientoInventarioById(id);
        if (movimientoInventario != null) {
            return ResponseEntity.ok(movimientoInventario);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public MovimientoInventario createMovimientoInventario(@RequestBody MovimientoInventario movimientoInventario) {
        return movimientoInventarioService.saveMovimientoInventario(movimientoInventario);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MovimientoInventario> updateMovimientoInventario(@PathVariable int id, @RequestBody MovimientoInventario movimientoInventarioDetails) {
        MovimientoInventario movimientoInventario = movimientoInventarioService.getMovimientoInventarioById(id);
        if (movimientoInventario != null) {
            movimientoInventario.setProducto(movimientoInventarioDetails.getProducto());
            movimientoInventario.setTipo(movimientoInventarioDetails.getTipo());
            movimientoInventario.setCantidad(movimientoInventarioDetails.getCantidad());
            movimientoInventario.setFecha(movimientoInventarioDetails.getFecha());
            return ResponseEntity.ok(movimientoInventarioService.saveMovimientoInventario(movimientoInventario));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMovimientoInventario(@PathVariable int id) {
        if (movimientoInventarioService.getMovimientoInventarioById(id) != null) {
            movimientoInventarioService.deleteMovimientoInventario(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
