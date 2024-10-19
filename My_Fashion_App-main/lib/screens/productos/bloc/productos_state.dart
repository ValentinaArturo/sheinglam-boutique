part of 'productos_bloc.dart';

abstract class ProductoState extends BaseState {}

class ProductoInitial extends ProductoState {}

class ProductoInProgress extends ProductoState {}

class ProductoSuccess extends ProductoState {
  final List<ProductoListModel> productos;

  ProductoSuccess({
    required this.productos,
  });
}

class ProductoError extends ProductoState {
  final String message;

  ProductoError({
    required this.message,
  });
}
