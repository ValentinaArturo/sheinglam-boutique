package com.tienda.tienda.controller;

import com.tienda.tienda.model.Pais;
import com.tienda.tienda.service.PaisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/paises")
public class PaisController {

    @Autowired
    private PaisService paisService;

    @GetMapping
    public List<Pais> getAllPaises() {
        return paisService.getAllPaises();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pais> getPaisById(@PathVariable int id) {
        Pais pais = paisService.getPaisById(id);
        if (pais != null) {
            return ResponseEntity.ok(pais);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Pais createPais(@RequestBody Pais pais) {
        return paisService.savePais(pais);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Pais> updatePais(@PathVariable int id, @RequestBody Pais paisDetails) {
        Pais pais = paisService.getPaisById(id);
        if (pais != null) {
            pais.setNombre(paisDetails.getNombre());
            return ResponseEntity.ok(paisService.savePais(pais));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePais(@PathVariable int id) {
        if (paisService.getPaisById(id) != null) {
            paisService.deletePais(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
