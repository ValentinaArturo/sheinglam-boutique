part of 'productos_bloc.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object> get props => [];
}

class ImagenShown extends ProductoEvent {}

class ProductoShown extends ProductoEvent {}

class CategoriaShown extends ProductoEvent {}

class ProductoPromocionShown extends ProductoEvent {}
