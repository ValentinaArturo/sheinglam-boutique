//package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controllers;
//
//import javax.persistence.*;
//
//@Entity
//@Table(name = "detalle_factura")
//public class DetalleFactura {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int idDetalleFactura;
//    
//    @ManyToOne
//    @JoinColumn(name = "factura_id")
//    private Factura factura;
//
//    @ManyToOne
//    @JoinColumn(name = "producto_id")
//    private Producto producto;
//    
//    private int cantidad;
//    private double precioUnitario;
//    private double subtotal;
//
//    // Getters and Setters
//}


