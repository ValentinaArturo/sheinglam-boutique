package com.tienda.tienda.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.tienda.tienda.service.PinService;

@RestController
@RequestMapping("/api/pin")
public class PinController {

    @Autowired
    private PinService pinService;

    @PostMapping("/send")
    public ResponseEntity<String> sendPin(@RequestParam String email) {
        pinService.sendPin(email);
        return ResponseEntity.ok("PIN enviado a " + email);
    }

    @PostMapping("/validate")
    public ResponseEntity<String> validatePin(@RequestParam String email, @RequestParam String pin) {
        boolean isValid = pinService.validatePin(email, pin);
        return isValid ? ResponseEntity.ok("PIN válido") : ResponseEntity.status(400).body("PIN inválido");
    }
}
