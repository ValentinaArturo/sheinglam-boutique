//package com.sheinglam_boutique_backend.sheinglam_boutique_backend.controllers;
//
//import javax.persistence.*;
//
//@Entity
//@Table(name = "dirección_envío")
//public class DireccionEnvio {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int idDireccion;
//    
//    @ManyToOne
//    @JoinColumn(name = "cliente_id")
//    private Cliente cliente;
//    
//    private String direccion;
//
//    @ManyToOne
//    @JoinColumn(name = "ciudad_id")
//    private Ciudad ciudad;
//
//    private String codigoPostal;
//
//    @ManyToOne
//    @JoinColumn(name = "país_id")
//    private Pais pais;
//
//    // Getters and Setters
//}


