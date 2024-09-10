package com.tienda.tienda.dto;

import com.tienda.tienda.model.Cliente;
import com.tienda.tienda.model.DireccionEnvio;
import com.tienda.tienda.model.Usuario;

public class ClienteDTO {
    private Usuario usuario;
    private Cliente cliente;
    private DireccionEnvio direccionEnvio;

    // Getters and Setters
    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public DireccionEnvio getDireccionEnvio() {
        return direccionEnvio;
    }

    public void setDireccionEnvio(DireccionEnvio direccionEnvio) {
        this.direccionEnvio = direccionEnvio;
    }
}