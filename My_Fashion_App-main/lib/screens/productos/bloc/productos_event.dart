part of 'productos_bloc.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object> get props => [];
}

class ProductoShown extends ProductoEvent {}
