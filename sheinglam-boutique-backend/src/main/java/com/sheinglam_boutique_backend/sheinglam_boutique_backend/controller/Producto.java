//package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controllers;
//
//import javax.persistence.*;
//
//@Entity
//@Table(name = "producto")
//public class Producto {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int idProducto;
//    
//    private String nombre;
//    private String descripcion;
//    private double precio;
//    
//    @ManyToOne
//    @JoinColumn(name = "talla_id")
//    private Talla talla;
//
//    @ManyToOne
//    @JoinColumn(name = "color_id")
//    private Color color;
//    
//    private int stock;
//
//    @ManyToOne
//    @JoinColumn(name = "proveedor_id")
//    private Proveedor proveedor;
//
//    // Getters and Setters
//}



