part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class DireccionEnvioShown extends PaymentEvent {
  final int idCliente;

  const DireccionEnvioShown({
    required this.idCliente,
  });
}

class EnvioShown extends PaymentEvent {
  final int idDepartamento;

  const EnvioShown({
    required this.idDepartamento,
  });
}

class PedidoCreated extends PaymentEvent {
  final int idCliente;
  final int idMetodoPago;
  final String fecha;
  final double total;
  final String nit;

  const PedidoCreated({
    required this.idCliente,
    required this.idMetodoPago,
    required this.fecha,
    required this.total,
    required this.nit,
  });
}

class DetallePedidoCreated extends PaymentEvent {
  final int idPedido;
  final int idProducto;
  final int cantidad;
  final double precio;
  final double subTotal;

  const DetallePedidoCreated({
    required this.idPedido,
    required this.idProducto,
    required this.cantidad,
    required this.precio,
    required this.subTotal,
  });
}

class EstadoPedidoCreated extends PaymentEvent {
  final String estado;

  const EstadoPedidoCreated({
    required this.estado,
  });
}

class EnvioCreated extends PaymentEvent {
  final int idPedido;
  final String metodoEnvio;
  final double costoEnvio;
  final String fechaEnvio;

  const EnvioCreated({
    required this.idPedido,
    required this.metodoEnvio,
    required this.costoEnvio,
    required this.fechaEnvio,
  });
}

class FacturaCreated extends PaymentEvent {
  final int idPedido;
  final double total;
  final String fecha;

  const FacturaCreated({
    required this.idPedido,
    required this.total,
    required this.fecha,
  });
}

class FacturaDetalleCreated extends PaymentEvent {
  final int idFactura;
  final int idProducto;
  final int cantidad;
  final double precioUntario;
  final double subTotal;

  const FacturaDetalleCreated({
    required this.idFactura,
    required this.idProducto,
    required this.cantidad,
    required this.precioUntario,
    required this.subTotal,
  });
}
