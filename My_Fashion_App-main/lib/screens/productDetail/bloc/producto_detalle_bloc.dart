import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/productDetail/model/carrito_list_model.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';
import 'package:my_fashion_app/screens/productDetail/service/producto_detalle_service.dart';

part 'producto_detalle_event.dart';
part 'producto_detalle_state.dart';

class ProductoDetalleBloc
    extends Bloc<ProductoDetalleEvent, ProductoDetalleState> {
  ProductoDetalleBloc() : super(ProductoDetalleInitial()) {
    on<ImagenShown>(getImageByProduct);
    on<CarritoShown>(getCarrito);
    on<CarritoCreated>(createCarrito);
    on<CarritoAdded>(agregarCarrito);
    on<CarritoUpdated>(updateCarrito);
  }

  final ProductoDetalleService service = ProductoDetalleService();

  Future<void> getImageByProduct(
    ImagenShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoDetalleInProgress(),
    );
    try {
      final ImagenListModel resp = await service.getImagenProducto(
        productoId: event.idProducto,
      );
      emit(
        ProductoDetalleSuccess(imagen: resp),
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
          ProductoDetalleError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getCarrito(
    CarritoShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoDetalleInProgress(),
    );
    try {
      final CarritoListModel resp = await service.getCarritoById(
        id: event.idCliente,
      );
      emit(
        CarritoObtainedSuccess(carrito: resp),
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
          ProductoDetalleError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createCarrito(
    CarritoCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoDetalleInProgress(),
    );
    try {
      await service.crearCarrito(
        idCliente: event.idCliente,
      );
      emit(
        CarritoCreatedSuccess(),
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
          ProductoDetalleError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> agregarCarrito(
    CarritoAdded event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoDetalleInProgress(),
    );
    try {
      await service.agregarCarrito(
        idCarrito: event.idCarrito,
        idProducto: event.idProducto,
        cantidad: event.cantidad,
      );
      emit(
        CarritoAddedSuccess(),
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
          ProductoDetalleError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateCarrito(
    CarritoUpdated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoDetalleInProgress(),
    );
    try {
      await service.editarCarrito(
        id: event.id,
        idCarrito: event.idCarrito,
        idProducto: event.idProducto,
        cantidad: event.cantidad,
      );
      emit(
        CarritoAddedSuccess(),
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
          ProductoDetalleError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
