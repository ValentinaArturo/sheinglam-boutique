package com.tienda.tienda.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "detalle_pago")
public class DetallePago {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idDetallePago;
    
    @ManyToOne
    @JoinColumn(name = "pedido_id")
    private Pedido pedido;

    @ManyToOne
    @JoinColumn(name = "metodo_pago_id")
    private MetodoPago metodoPago;
    
    private double monto;
    private Date fecha;

    // Getters and Setters
    public int getIdDetallePago() {
        return idDetallePago;
    }

    public void setIdDetallePago(int idDetallePago) {
        this.idDetallePago = idDetallePago;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public MetodoPago getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(MetodoPago metodoPago) {
        this.metodoPago = metodoPago;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}

