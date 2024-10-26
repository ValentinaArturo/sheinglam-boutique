part of 'cart_bloc.dart';

abstract class CartState extends BaseState {}

class CartInitial extends CartState {}

class CartInProgress extends CartState {}

class CartListSuccess extends CartState {
  final List<CartListModel> carrito;
  CartListSuccess({
    required this.carrito,
  });
}

class ImagenSuccess extends CartState {
  final List<ImagenListModel> imagen;

  ImagenSuccess({
    required this.imagen,
  });
}

class CartError extends CartState {
  final String message;

  CartError({
    required this.message,
  });
}
