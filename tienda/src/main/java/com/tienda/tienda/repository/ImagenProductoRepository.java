package com.tienda.tienda.repository;

import com.tienda.tienda.model.ImagenProducto;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ImagenProductoRepository extends JpaRepository<ImagenProducto, Integer> {

	List<ImagenProducto> findByProductoId_idProducto(int productoId);
}
