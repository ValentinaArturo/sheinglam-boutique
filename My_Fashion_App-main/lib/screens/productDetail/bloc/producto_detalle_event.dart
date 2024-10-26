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

class CarritoShown extends ProductoDetalleEvent {
  final int idCliente;

  const CarritoShown({
    required this.idCliente,
  });
}

class CarritoCreated extends ProductoDetalleEvent {
  final int idCliente;

  const CarritoCreated({
    required this.idCliente,
  });
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

class CarritoUpdated extends ProductoDetalleEvent {
  final int id;
  final int idCarrito;
  final int idProducto;
  final int cantidad;

  const CarritoUpdated({
    required this.id,
    required this.idCarrito,
    required this.idProducto,
    required this.cantidad,
  });
}
