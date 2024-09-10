package com.tienda.tienda.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import com.tienda.tienda.model.Usuario;

import com.tienda.tienda.repository.UsuarioRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

@CrossOrigin
@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

    public Usuario getUsuarioById(int id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    public Usuario saveUsuario(Usuario usuario) {
        String encodedPassword = passwordEncoder.encode(usuario.getContraseña());
        usuario.setContraseña(encodedPassword);
        return usuarioRepository.save(usuario);
    }

    public void deleteUsuario(int id) {
        usuarioRepository.deleteById(id);
    }

    public Usuario getUsuarioByEmailAndPassword(String email, String password) {
        Usuario usuario = usuarioRepository.findByCorreoElectronicoAndContraseña(email, password);
        
        if (usuario != null && passwordEncoder.matches(password, usuario.getContraseña())) {
            return usuario;
        }
        return null; 
    }
}
