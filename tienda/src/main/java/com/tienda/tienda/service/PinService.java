package com.tienda.tienda.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class PinService {

    private final EmailService emailService;
    private final Map<String, String> pinStorage = new HashMap<>(); // Guarda los PINs por correo

    @Autowired
    public PinService(EmailService emailService) {
        this.emailService = emailService;
    }

    public String generatePin() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000)); // Genera un PIN de 6 dígitos
    }

    public void sendPin(String email) {
        String pin = generatePin();
        pinStorage.put(email, pin); // Guarda el PIN asociado al correo
        String subject = "Su código PIN";
        String body = "Su código PIN es: " + pin;
        emailService.sendEmail(email, subject, body);
    }

    public boolean validatePin(String email, String pin) {
        String storedPin = pinStorage.get(email);
        return storedPin != null && storedPin.equals(pin);
    }
}
