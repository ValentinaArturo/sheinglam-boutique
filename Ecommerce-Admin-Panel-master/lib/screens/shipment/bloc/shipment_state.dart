part of 'shipment_bloc.dart';

abstract class ShipmentState extends BaseState {}

class ShipmentInitial extends ShipmentState {}

class ShipmentInProgress extends ShipmentState {}

class ShipmentFacturaSuccess extends ShipmentState {
  final List<FacturaListModel> facturas;

  ShipmentFacturaSuccess({
    required this.facturas,
  });
}

class ShipmentDetalleFacturaSuccess extends ShipmentState {
  final List<DetalleFacturaListModel> detalleFacturas;

  ShipmentDetalleFacturaSuccess({
    required this.detalleFacturas,
  });
}

class ShipmentPedidosSuccess extends ShipmentState {
  final List<ShipmentListModel> pedidos;

  ShipmentPedidosSuccess({
    required this.pedidos,
  });
}

class ShipmentPedidosError extends ShipmentState {
  final String message;

  ShipmentPedidosError({
    required this.message,
  });
}
