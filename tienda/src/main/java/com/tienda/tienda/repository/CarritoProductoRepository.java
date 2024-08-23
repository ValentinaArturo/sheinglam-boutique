package com.tienda.tienda.repository;

import com.tienda.tienda.model.CarritoProducto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarritoProductoRepository extends JpaRepository<CarritoProducto, Integer> {
}
