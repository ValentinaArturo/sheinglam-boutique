part of 'productos_bloc.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object> get props => [];
}

final class ProductoShown extends ProductoEvent {}

final class CategoriaShown extends ProductoEvent {}

final class ProductoPromocionShown extends ProductoEvent {}

final class ProductoCategoriaShown extends ProductoEvent {}

final class ImagenesProductoShown extends ProductoEvent {}

final class ProductoCategoriaEditedShown extends ProductoEvent {
  final int idProducto;
  final int idCategoria;
  final int idProductoCategoria;

  ProductoCategoriaEditedShown({
    required this.idProducto,
    required this.idCategoria,
    required this.idProductoCategoria,
  });
}

final class ProveedorShown extends ProductoEvent {}

final class TallaShown extends ProductoEvent {}

final class ColorShown extends ProductoEvent {}

final class ImagenByIdShown extends ProductoEvent {
  final int productoId;

  const ImagenByIdShown({
    required this.productoId,
  });
}

final class ImageCreated extends ProductoEvent {
  final int idProducto;
  final String imagen;

  const ImageCreated({
    required this.idProducto,
    required this.imagen,
  });
}

final class ProductoSaved extends ProductoEvent {
  final String nombre;
  final String descripcion;
  final double precio;
  final int idTalla;
  final int idColor;
  final int stock;
  final int idProveedor;

  const ProductoSaved({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.idTalla,
    required this.idColor,
    required this.stock,
    required this.idProveedor,
  });
}

final class CategoriaSaved extends ProductoEvent {
  final int idProducto;
  final int idCategoria;

  const CategoriaSaved({
    required this.idProducto,
    required this.idCategoria,
  });
}

final class ProductoPromocionSaved extends ProductoEvent {
  final int idProducto;
  final int idPromocion;

  const ProductoPromocionSaved({
    required this.idProducto,
    required this.idPromocion,
  });
}

final class ProductoEdited extends ProductoEvent {
  final String nombre;
  final String descripcion;
  final double precio;
  final int idTalla;
  final int idColor;
  final int stock;
  final int idProveedor;
  final int id;

  const ProductoEdited({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.idTalla,
    required this.idColor,
    required this.stock,
    required this.idProveedor,
    required this.id,
  });
}

final class ProductoDeleted extends ProductoEvent {
  final int id;

  const ProductoDeleted({
    required this.id,
  });
}
