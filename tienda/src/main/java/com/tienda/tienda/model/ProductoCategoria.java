package com.tienda.tienda.model;

import jakarta.persistence.*;

@Entity
@Table(name = "producto_categoria")
public class ProductoCategoria {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idProductoCategoria;
    
    @ManyToOne
    @JoinColumn(name = "producto_id")
    private Producto producto;

    @ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;

    // Getters and Setters
    public int getIdProductoCategoria() {
        return idProductoCategoria;
    }

    public void setIdProductoCategoria(int idProductoCategoria) {
        this.idProductoCategoria = idProductoCategoria;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
}

