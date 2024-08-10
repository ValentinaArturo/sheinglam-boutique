//package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controllers;
//
//import javax.persistence.*;
//import java.util.Date;
//
//@Entity
//@Table(name = "pedido")
//public class Pedido {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int idPedido;
//    
//    @ManyToOne
//    @JoinColumn(name = "cliente_id")
//    private Cliente cliente;
//    
//    private Date fecha;
//    private double total;
//
//    @ManyToOne
//    @JoinColumn(name = "método_pago_id")
//    private MetodoPago metodoPago;
//
//    private String nit;
//
//    // Getters and Setters
//}


