part of 'productos_bloc.dart';

abstract class ProductoState extends BaseState {}

final class ProductoInitial extends ProductoState {}

final class ProductoInProgress extends ProductoState {}

final class ProductoSuccess extends ProductoState {
  final List<ProductoListModel> productos;

  ProductoSuccess({
    required this.productos,
  });
}

final class CategoriaSuccess extends ProductoState {
  final List<CategoriaListModel> categorias;

  CategoriaSuccess({
    required this.categorias,
  });
}

final class ProductoPromocionSuccess extends ProductoState {
  final List<ProductoPromocionListModel> promociones;

  ProductoPromocionSuccess({
    required this.promociones,
  });
}

final class ProveedorSuccess extends ProductoState {
  final List<ProveedorListModel> proveedores;

  ProveedorSuccess({
    required this.proveedores,
  });
}

final class TallaSuccess extends ProductoState {
  final List<TallaListModel> tallas;

  TallaSuccess({
    required this.tallas,
  });
}

final class ColorSuccess extends ProductoState {
  final List<ColorListModel> colores;

  ColorSuccess({
    required this.colores,
  });
}

final class ProductoCreatedSuccess extends ProductoState {}

final class CategoriaCreatedSuccess extends ProductoState {}

final class ProductoPromocionCreatedSuccess extends ProductoState {}

final class ProductoEditedSuccess extends ProductoState {}

final class ProductoDeletedSuccess extends ProductoState {}

final class ProductoError extends ProductoState {
  final String message;

  ProductoError({
    required this.message,
  });
}
