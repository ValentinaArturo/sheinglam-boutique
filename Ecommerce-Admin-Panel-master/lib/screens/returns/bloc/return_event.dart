part of 'return_bloc.dart';

abstract class ReturnEvent extends Equatable {
  const ReturnEvent();

  @override
  List<Object> get props => [];
}

final class ReturnShown extends ReturnEvent {}

final class ReturnCreated extends ReturnEvent {
  final int idPedido;
  final String motivo;
  final String fechaDevolucion;
  final String estado;

  const ReturnCreated({
    required this.idPedido,
    required this.motivo,
    required this.fechaDevolucion,
    required this.estado,
  });
}

final class ReturnEdited extends ReturnEvent {
  final int id;
  final int idPedido;
  final String motivo;
  final String fechaDevolucion;
  final String estado;

  const ReturnEdited({
    required this.id,
    required this.idPedido,
    required this.motivo,
    required this.fechaDevolucion,
    required this.estado,
  });
}

final class ReturnDeleted extends ReturnEvent {
  final int id;

  const ReturnDeleted({
    required this.id,
  });
}
