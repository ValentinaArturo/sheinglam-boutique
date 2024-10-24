package com.tienda.tienda.controller;

import com.tienda.tienda.model.Proveedor;
import com.tienda.tienda.service.ProveedorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/proveedores")
public class ProveedorController {

    @Autowired
    private ProveedorService proveedorService;

    @GetMapping
    public List<Proveedor> getAllProveedores() {
        return proveedorService.getAllProveedores();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Proveedor> getProveedorById(@PathVariable int id) {
        Proveedor proveedor = proveedorService.getProveedorById(id);
        if (proveedor != null) {
            return ResponseEntity.ok(proveedor);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Proveedor createProveedor(@RequestBody Proveedor proveedor) {
        return proveedorService.saveProveedor(proveedor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Proveedor> updateProveedor(@PathVariable int id, @RequestBody Proveedor proveedorDetails) {
        Proveedor proveedor = proveedorService.getProveedorById(id);
        if (proveedor != null) {
            proveedor.setNombre(proveedorDetails.getNombre());
            proveedor.setDireccion(proveedorDetails.getDireccion());
            proveedor.setTelefono(proveedorDetails.getTelefono());
            proveedor.setCorreoElectronico(proveedorDetails.getCorreoElectronico());
            proveedor.setNit(proveedorDetails.getNit());
            return ResponseEntity.ok(proveedorService.saveProveedor(proveedor));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProveedor(@PathVariable int id) {
        if (proveedorService.getProveedorById(id) != null) {
            proveedorService.deleteProveedor(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
