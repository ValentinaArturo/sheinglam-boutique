package com.tienda.tienda.model;

import jakarta.persistence.*;

@Entity
@Table(name = "producto_promocion")
public class ProductoPromocion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idProductoPromocion;
    
    @ManyToOne
    @JoinColumn(name = "producto_id")
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "promocion_id")
    private Promocion promocion;

    // Getters and Setters
    public int getIdProductoPromocion() {
        return idProductoPromocion;
    }

    public void setIdProductoPromocion(int idProductoPromocion) {
        this.idProductoPromocion = idProductoPromocion;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Promocion getPromocion() {
        return promocion;
    }

    public void setPromocion(Promocion promocion) {
        this.promocion = promocion;
    }
}

