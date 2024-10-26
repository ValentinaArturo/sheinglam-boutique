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

class ImagenSuccess extends ProductoState {
  final List<ImagenListModel> imagen;

  ImagenSuccess({
    required this.imagen,
  });
}

class CategoriaSuccess extends ProductoState {
  final List<CategoriaListModel> categorias;

  CategoriaSuccess({
    required this.categorias,
  });
}

class ProductoPromocionSuccess extends ProductoState {
  final List<ProductoPromocionListModel> productosPromocion;

  ProductoPromocionSuccess({
    required this.productosPromocion,
  });
}

class ProductoError extends ProductoState {
  final String message;

  ProductoError({
    required this.message,
  });
}
