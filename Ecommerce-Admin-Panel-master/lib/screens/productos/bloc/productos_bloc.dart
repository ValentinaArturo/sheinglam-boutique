import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/color_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_promocion_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/talla_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/service/productos_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoBloc() : super(ProductoInitial()) {
    on<ProductoShown>(getProducto);
    on<TallaShown>(getTalla);
    on<ColorShown>(getColor);
    on<ProveedorShown>(getProveedor);
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

  Future<void> getCategoria(
    CategoriaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<CategoriaListModel> resp = await service.getCategoria();
      emit(
        CategoriaSuccess(categorias: resp),
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

  Future<void> getProductoPromocion(
    ProductoPromocionShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<ProductoPromocionListModel> resp =
          await service.getProductoPromocion();
      emit(
        ProductoPromocionSuccess(promociones: resp),
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

  Future<void> getTalla(
    TallaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<TallaListModel> resp = await service.getTalla();
      emit(
        TallaSuccess(tallas: resp),
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

  Future<void> getColor(
    ColorShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<ColorListModel> resp = await service.getColor();
      emit(
        ColorSuccess(colores: resp),
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

  Future<void> getProveedor(
    ProveedorShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      final List<ProveedorListModel> resp = await service.getProveedor();
      emit(
        ProveedorSuccess(proveedores: resp),
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

  Future<void> createImagenProducto(
    ImageCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.createImagenProducto(
        idProducto: event.idProducto,
        imagenProducto: event.imagen,
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

  Future<void> createCategoria(
    CategoriaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.createCategoriaProducto(
        idProducto: event.idProducto,
        idCategoria: event.idCategoria,
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

  Future<void> createProductoPromocion(
    ProductoPromocionSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProductoInProgress(),
    );
    try {
      await service.createProductoPromocion(
        idProducto: event.idProducto,
        idPromocion: event.idPromocion,
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
