package com.tienda.tienda.controller;

import com.tienda.tienda.model.Rol;
import com.tienda.tienda.service.RolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/roles")
public class RolController {

    @Autowired
    private RolService rolService;

    @GetMapping
    public List<Rol> getAllRoles() {
        return rolService.getAllRoles();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Rol> getRolById(@PathVariable int id) {
        Rol rol = rolService.getRolById(id);
        if (rol != null) {
            return ResponseEntity.ok(rol);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Rol createRol(@RequestBody Rol rol) {
        return rolService.saveRol(rol);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Rol> updateRol(@PathVariable int id, @RequestBody Rol rolDetails) {
        Rol rol = rolService.getRolById(id);
        if (rol != null) {
            rol.setNombre(rolDetails.getNombre());
            return ResponseEntity.ok(rolService.saveRol(rol));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRol(@PathVariable int id) {
        if (rolService.getRolById(id) != null) {
            rolService.deleteRol(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
