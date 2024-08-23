package com.tienda.tienda.controller;

import com.tienda.tienda.model.Talla;
import com.tienda.tienda.service.TallaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tallas")
public class TallaController {

    @Autowired
    private TallaService tallaService;

    @GetMapping
    public List<Talla> getAllTallas() {
        return tallaService.getAllTallas();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Talla> getTallaById(@PathVariable int id) {
        Talla talla = tallaService.getTallaById(id);
        if (talla != null) {
            return ResponseEntity.ok(talla);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Talla createTalla(@RequestBody Talla talla) {
        return tallaService.saveTalla(talla);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Talla> updateTalla(@PathVariable int id, @RequestBody Talla tallaDetails) {
        Talla talla = tallaService.getTallaById(id);
        if (talla != null) {
            talla.setTalla(tallaDetails.getTalla());
            return ResponseEntity.ok(tallaService.saveTalla(talla));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTalla(@PathVariable int id) {
        if (tallaService.getTallaById(id) != null) {
            tallaService.deleteTalla(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
