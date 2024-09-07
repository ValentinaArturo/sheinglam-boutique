package com.tienda.tienda.controller;

import com.tienda.tienda.model.Usuario;
import com.tienda.tienda.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Usuario user) {
        if ("usuarioEjemplo".equals(user.getNombre()) && "passwordEjemplo".equals(user.getContraseña())) {
            String token = authService.generateToken(user.getNombre());
            return ResponseEntity.ok(new JwtResponse(token));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    private static class JwtResponse {
        private String token;

        public JwtResponse(String token) {
            this.token = token;
        }

        public String getToken() {
            return token;
        }
    }
}
