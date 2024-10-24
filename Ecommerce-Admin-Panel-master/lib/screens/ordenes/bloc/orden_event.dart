part of 'orden_bloc.dart';

abstract class OrdenEvent extends Equatable {
  const OrdenEvent();

  @override
  List<Object> get props => [];
}

final class OrdenShown extends OrdenEvent {}

final class OrdenSaved extends OrdenEvent {
  final int idCliente;
  final String fecha;
  final double total;
  final int idMetodoPago;
  final String nit;

  const OrdenSaved({
    required this.idCliente,
    required this.fecha,
    required this.total,
    required this.idMetodoPago,
    required this.nit,
  });
}

final class OrdenEdited extends OrdenEvent {
  final int id;
  final int idPedido;
  final int idEstadoPedido;
  final String fecha;

  const OrdenEdited({
    required this.id,
    required this.idPedido,
    required this.idEstadoPedido,
    required this.fecha,
  });
}

final class OrdenDeleted extends OrdenEvent {
  final int id;

  const OrdenDeleted({
    required this.id,
  });
}
