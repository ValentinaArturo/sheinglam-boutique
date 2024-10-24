package com.tienda.tienda.dto;


public class TarifaEnvioDTO {
    private String departamento;
    private double precio;

    public TarifaEnvioDTO(String departamento, double precio) {
        this.departamento = departamento;
        this.precio = precio;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}