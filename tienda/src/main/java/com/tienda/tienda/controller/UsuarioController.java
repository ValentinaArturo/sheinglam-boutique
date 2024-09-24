package com.tienda.tienda.controller;

import com.tienda.tienda.model.Usuario;
import com.tienda.tienda.service.PasswordService;
import com.tienda.tienda.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;


    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public List<Usuario> getAllUsuarios() {
        return usuarioService.getAllUsuarios();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Usuario> getUsuarioById(@PathVariable int id) {
        Usuario usuario = usuarioService.getUsuarioById(id);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    
    @GetMapping("/login")
    public ResponseEntity<Usuario> getUsuarioByEmailAndPassword(
            @RequestParam String email, 
            @RequestParam String password) {
        Usuario usuario = usuarioService.getUsuarioByEmail(email);
        
        if (usuario != null && passwordEncoder.matches(password, usuario.getContraseña())) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.status(401).build(); // 401 Unauthorized si las credenciales no son válidas
        }
    }

    @PostMapping
    public Usuario createUsuario(@RequestBody Usuario usuario) {
        String password = passwordEncoder.encode(usuario.getContraseña());
        return usuarioService.saveUsuario(usuario, password);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Usuario> updateUsuario(@PathVariable int id, @RequestBody Usuario usuarioDetails) {
        Usuario usuario = usuarioService.getUsuarioById(id);        
        if (usuario != null) {
            usuario.setNombre(usuarioDetails.getNombre());
            usuario.setApellido(usuarioDetails.getApellido());
            usuario.setCorreoElectronico(usuarioDetails.getCorreoElectronico());
            usuario.setContraseña(usuarioDetails.getContraseña());
            usuario.setRol(usuarioDetails.getRol());
            String password = passwordEncoder.encode(usuario.getContraseña());
            return ResponseEntity.ok(usuarioService.saveUsuario(usuario, password));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUsuario(@PathVariable int id) {
        if (usuarioService.getUsuarioById(id) != null) {
            usuarioService.deleteUsuario(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}