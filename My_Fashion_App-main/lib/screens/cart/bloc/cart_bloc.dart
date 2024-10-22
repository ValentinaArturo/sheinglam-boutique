import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';
import 'package:my_fashion_app/screens/cart/service/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartListShown>(getCartList);
  }

  final CartService service = CartService();

  Future<void> getCartList(
    CartListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CartInProgress(),
    );
    try {
      final List<CartListModel> resp = await service.getCart();
      emit(
        CartListSuccess(carrito: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          CartError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
