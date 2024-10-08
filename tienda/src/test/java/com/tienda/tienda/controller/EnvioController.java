package com.tienda.tienda.controller;

import com.tienda.tienda.model.Envio;
import com.tienda.tienda.service.EnvioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/envios")
public class EnvioController {

    @Autowired
    private EnvioService envioService;

    @GetMapping
    public List<Envio> getAllEnvios() {
        return envioService.getAllEnvios();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Envio> getEnvioById(@PathVariable int id) {
        Envio envio = envioService.getEnvioById(id);
        if (envio != null) {
            return ResponseEntity.ok(envio);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public Envio createEnvio(@RequestBody Envio envio) {
        return envioService.saveEnvio(envio);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Envio> updateEnvio(@PathVariable int id, @RequestBody Envio envioDetails) {
        Envio envio = envioService.getEnvioById(id);
        if (envio != null) {
            envio.setPedido(envioDetails.getPedido());
            envio.setMetodoEnvio(envioDetails.getMetodoEnvio());
            envio.setCostoEnvio(envioDetails.getCostoEnvio());
            envio.setFechaEnvio(envioDetails.getFechaEnvio());
            return ResponseEntity.ok(envioService.saveEnvio(envio));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEnvio(@PathVariable int id) {
        if (envioService.getEnvioById(id) != null) {
            envioService.deleteEnvio(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
