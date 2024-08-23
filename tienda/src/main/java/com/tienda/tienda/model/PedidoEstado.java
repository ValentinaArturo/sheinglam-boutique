package com.tienda.tienda.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "pedido_estado")
public class PedidoEstado {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idPedidoEstado;
    
    @ManyToOne
    @JoinColumn(name = "pedido_id")
    private Pedido pedido;

    @ManyToOne
    @JoinColumn(name = "estado_pedido_id")
    private EstadoPedido estadoPedido;
    
    private Date fecha;

    // Getters and Setters
    public int getIdPedidoEstado() {
        return idPedidoEstado;
    }

    public void setIdPedidoEstado(int idPedidoEstado) {
        this.idPedidoEstado = idPedidoEstado;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public EstadoPedido getEstadoPedido() {
        return estadoPedido;
    }

    public void setEstadoPedido(EstadoPedido estadoPedido) {
        this.estadoPedido = estadoPedido;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}

