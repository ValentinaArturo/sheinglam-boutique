package com.tienda.tienda.repository;

import com.tienda.tienda.model.DireccionEnvio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface DireccionEnvioRepository extends JpaRepository<DireccionEnvio, Integer> {
	List<DireccionEnvio> findByCliente_IdCliente(int clienteId);

}
