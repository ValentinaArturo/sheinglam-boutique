package com.tienda.tienda.controller;

import com.tienda.tienda.model.Promocion;
import com.tienda.tienda.service.PromocionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/promociones")
public class PromocionController {

    @Autowired
    private PromocionService promocionService;

    @GetMapping
    public List<Promocion> getAllPromociones() {
        return promocionService.getAllPromociones();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Promocion> getPromocionById(@PathVariable int id) {
        Promocion promocion = promocionService.getPromocionById(id);
        if (promocion != null) {
            return ResponseEntity.ok(promocion);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Promocion createPromocion(@RequestBody Promocion promocion) {
        return promocionService.savePromocion(promocion);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Promocion> updatePromocion(@PathVariable int id, @RequestBody Promocion promocionDetails) {
        Promocion promocion = promocionService.getPromocionById(id);
        if (promocion != null) {
            promocion.setNombre(promocionDetails.getNombre());
            promocion.setDescripcion(promocionDetails.getDescripcion());
            promocion.setDescuento(promocionDetails.getDescuento());
            return ResponseEntity.ok(promocionService.savePromocion(promocion));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePromocion(@PathVariable int id) {
        if (promocionService.getPromocionById(id) != null) {
            promocionService.deletePromocion(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
