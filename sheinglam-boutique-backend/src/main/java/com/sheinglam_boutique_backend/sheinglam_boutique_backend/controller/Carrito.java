package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controller;

import javax.persistence.*;

@Entity
@Table(name = "carrito")
public class Carrito {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idCarrito;
    
    @ManyToOne
    @JoinColumn(name = "cliente_id")
    private Cliente cliente;

    // Getters and Setters
}


