package com.tienda.tienda.repository;

import com.tienda.tienda.model.ProductoPromocion;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoPromocionRepository extends JpaRepository<ProductoPromocion, Integer> {

	List<ProductoPromocion> findByProducto_IdProducto(int productoId);
}
