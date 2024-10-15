import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/service/productos_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoBloc() : super(ProductoInitial()) {
    on<ProductoShown>(getProducto);
    on<ProductoSaved>(createProducto);
    on<ProductoEdited>(updateProducto);
    on<ProductoDeleted>(deleteProducto);
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

  Future<void> createProducto(
    ProductoSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.createProducto(
        nombre: event.nombre,
        descripcion: event.descripcion,
        precio: event.precio,
        idTalla: event.idTalla,
        idColor: event.idColor,
        stock: event.stock,
        idProveedor: event.idProveedor,
      );
      emit(
        ProductoCreatedSuccess(),
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

  Future<void> updateProducto(
    ProductoEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.updateProducto(
        nombre: event.nombre,
        descripcion: event.descripcion,
        precio: event.precio,
        idTalla: event.idTalla,
        idColor: event.idColor,
        stock: event.stock,
        idProveedor: event.idProveedor,
        id: event.id,
      );
      emit(
        ProductoEditedSuccess(),
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

  Future<void> deleteProducto(
    ProductoDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.deleteProducto(
        id: event.id,
      );
      emit(
        ProductoDeletedSuccess(),
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
