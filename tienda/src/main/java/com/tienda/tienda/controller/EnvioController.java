package com.tienda.tienda.controller;

import com.tienda.tienda.dto.TarifaEnvioDTO;
import com.tienda.tienda.model.Envio;
import com.tienda.tienda.model.TarifaEnvio;
import com.tienda.tienda.service.EnvioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api/envios")
public class EnvioController {

    @Autowired
    private EnvioService envioService;

    @GetMapping
    public List<Envio> getAllEnvios() {
        return envioService.getAllEnvios();
    }
    
    @GetMapping("/{departamento}")
    public TarifaEnvioDTO getTarifaEnvio(@PathVariable String departamento) {
        double tarifa = TarifaEnvio.getTarifa(departamento);
        if (tarifa != -1.0) {
            return new TarifaEnvioDTO(departamento, tarifa);
        } else {
            return new TarifaEnvioDTO(departamento, 0.0); // o manejar el caso de departamento no válido
        }
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
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
