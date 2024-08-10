//package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controllers;
//
//import javax.persistence.*;
//import java.util.Date;
//
//@Entity
//@Table(name = "detalle_pago")
//public class DetallePago {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int idDetallePago;
//    
//    @ManyToOne
//    @JoinColumn(name = "pedido_id")
//    private Pedido pedido;
//
//    @ManyToOne
//    @JoinColumn(name = "método_pago_id")
//    private MetodoPago metodoPago;
//    
//    private double monto;
//    private Date fecha;
//
//    // Getters and Setters
//}


