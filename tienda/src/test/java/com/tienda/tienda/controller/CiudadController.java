package com.tienda.tienda.controller;

import com.tienda.tienda.model.Ciudad;
import com.tienda.tienda.service.CiudadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ciudades")
public class CiudadController {

    @Autowired
    private CiudadService ciudadService;

    @GetMapping
    public List<Ciudad> getAllCiudades() {
        return ciudadService.getAllCiudades();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Ciudad> getCiudadById(@PathVariable int id) {
        Ciudad ciudad = ciudadService.getCiudadById(id);
        if (ciudad != null) {
            return ResponseEntity.ok(ciudad);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Ciudad createCiudad(@RequestBody Ciudad ciudad) {
        return ciudadService.saveCiudad(ciudad);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Ciudad> updateCiudad(@PathVariable int id, @RequestBody Ciudad ciudadDetails) {
        Ciudad ciudad = ciudadService.getCiudadById(id);
        if (ciudad != null) {
            ciudad.setNombre(ciudadDetails.getNombre());
            return ResponseEntity.ok(ciudadService.saveCiudad(ciudad));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCiudad(@PathVariable int id) {
        if (ciudadService.getCiudadById(id) != null) {
            ciudadService.deleteCiudad(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
