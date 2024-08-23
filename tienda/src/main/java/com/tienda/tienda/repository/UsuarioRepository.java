package com.tienda.tienda.repository;

import com.tienda.tienda.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Usuario findByCorreoElectronicoAndContraseña(String correoElectronico, String contraseña);

}
