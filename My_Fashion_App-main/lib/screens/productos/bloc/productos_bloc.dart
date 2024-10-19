import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';
import 'package:my_fashion_app/screens/productos/service/productos_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoBloc() : super(ProductoInitial()) {
    on<ProductoShown>(getProducto);
  }

  final ProductoService service = ProductoService();

  Future<void> getProducto(
    ProductoShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<ProductoListModel> resp = await service.getProducto();
      emit(
        ProductoSuccess(productos: resp),
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
          ProductoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
