part of 'producto_detalle_bloc.dart';

abstract class ProductoDetalleState extends BaseState {}

class ProductoDetalleInitial extends ProductoDetalleState {}

class ProductoDetalleInProgress extends ProductoDetalleState {}

class ProductoDetalleSuccess extends ProductoDetalleState {
  final ImagenListModel imagen;

  ProductoDetalleSuccess({
    required this.imagen,
  });
}

class CarritoCreatedSuccess extends ProductoDetalleState {}

class ProductoDetalleError extends ProductoDetalleState {
  final String message;

  ProductoDetalleError({
    required this.message,
  });
}
