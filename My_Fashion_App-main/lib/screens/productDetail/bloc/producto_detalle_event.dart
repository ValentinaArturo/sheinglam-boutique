part of 'producto_detalle_bloc.dart';

abstract class ProductoDetalleEvent extends Equatable {
  const ProductoDetalleEvent();

  @override
  List<Object> get props => [];
}

class ImagenShown extends ProductoDetalleEvent {
  final int idProducto;

  const ImagenShown({required this.idProducto});
}

class CarritoAdded extends ProductoDetalleEvent {
  final int idCarrito;
  final int idProducto;
  final int cantidad;

  const CarritoAdded({
    required this.idCarrito,
    required this.idProducto,
    required this.cantidad,
  });
}
