package com.tienda.tienda.controller;

import com.tienda.tienda.model.Usuario;
import com.tienda.tienda.service.AuthService;
import com.tienda.tienda.service.PasswordService;
import com.tienda.tienda.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @CrossOrigin
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email, @RequestParam String password) {
        Usuario usuario = usuarioService.getUsuarioByEmail(email);
        if (usuario != null && passwordEncoder.matches(password, usuario.getContraseña())) {
            String token = authService.generateToken(usuario.getNombre());

            return ResponseEntity.ok(new JwtResponse(token, usuario));
        } else {
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        }
    }

    private static class JwtResponse {
        private String token;
        private Usuario usuario;

        public JwtResponse(String token, Usuario usuario) {
            this.token = token;
            this.usuario = usuario;
        }

        public String getToken() {
            return token;
        }

        public Usuario getUsuario() {
            return usuario;
        }
    }
}