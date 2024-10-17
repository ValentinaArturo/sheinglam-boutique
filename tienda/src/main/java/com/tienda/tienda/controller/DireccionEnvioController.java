package com.tienda.tienda.controller;

import com.tienda.tienda.model.DireccionEnvio;
import com.tienda.tienda.service.DireccionEnvioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/direcciones-envio")
public class DireccionEnvioController {

    @Autowired
    private DireccionEnvioService direccionEnvioService;

    @GetMapping
    public List<DireccionEnvio> getAllDireccionesEnvio() {
        return direccionEnvioService.getAllDireccionesEnvio();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DireccionEnvio> getDireccionEnvioById(@PathVariable int id) {
        DireccionEnvio direccionEnvio = direccionEnvioService.getDireccionEnvioById(id);
        if (direccionEnvio != null) {
            return ResponseEntity.ok(direccionEnvio);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/cliente/{clienteId}")
    public ResponseEntity<List<DireccionEnvio>> getDireccionesEnvioByClienteId(@PathVariable int clienteId) {
        List<DireccionEnvio> direccionesEnvio = direccionEnvioService.getDireccionesEnvioByClienteId(clienteId);
        if (!direccionesEnvio.isEmpty()) {
            return ResponseEntity.ok(direccionesEnvio);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public DireccionEnvio createDireccionEnvio(@RequestBody DireccionEnvio direccionEnvio) {
        return direccionEnvioService.saveDireccionEnvio(direccionEnvio);
    }

    @PutMapping("/{id}")
    public ResponseEntity<DireccionEnvio> updateDireccionEnvio(@PathVariable int id, @RequestBody DireccionEnvio direccionEnvioDetails) {
        DireccionEnvio direccionEnvio = direccionEnvioService.getDireccionEnvioById(id);
        if (direccionEnvio != null) {
            direccionEnvio.setCliente(direccionEnvioDetails.getCliente());
            direccionEnvio.setDireccion(direccionEnvioDetails.getDireccion());
            direccionEnvio.setCiudad(direccionEnvioDetails.getCiudad());
            direccionEnvio.setCodigoPostal(direccionEnvioDetails.getCodigoPostal());
            direccionEnvio.setPais(direccionEnvioDetails.getPais());
            return ResponseEntity.ok(direccionEnvioService.saveDireccionEnvio(direccionEnvio));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDireccionEnvio(@PathVariable int id) {
        if (direccionEnvioService.getDireccionEnvioById(id) != null) {
            direccionEnvioService.deleteDireccionEnvio(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}