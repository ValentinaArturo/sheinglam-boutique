import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/proveedores/service/proveedor_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'proveedor_event.dart';
part 'proveedor_state.dart';

class ProveedorBloc extends Bloc<ProveedorEvent, ProveedorState> {
  ProveedorBloc() : super(ProveedorInitial()) {
    on<ProveedorShown>(getProveedor);
    on<ProveedorCreated>(createProveedor);
    on<ProveedorEdited>(editProveedor);
    on<ProveedorDeleted>(deleteProveedor);
  }

  final ProveedorService service = ProveedorService();

  Future<void> getProveedor(
    ProveedorShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProveedorInProgress(),
    );
    try {
      final List<ProveedorListModel> resp = await service.getProveedor();
      emit(
        ProveedorListSuccess(proveedores: resp),
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
          ProveedorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createProveedor(
    ProveedorCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProveedorInProgress(),
    );
    try {
      await service.createProveedor(
        nombre: event.nombre,
        direccion: event.direccion,
        telefono: event.telefono,
        email: event.email,
        nit: event.nit,
      );
      emit(
        ProveedorCreatedSuccess(),
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
          ProveedorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> editProveedor(
    ProveedorEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProveedorInProgress(),
    );
    try {
      await service.updateProveedor(
        id: event.id,
        nombre: event.nombre,
        direccion: event.direccion,
        telefono: event.telefono,
        email: event.email,
        nit: event.nit,
      );
      emit(
        ProveedorEditedSuccess(),
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
          ProveedorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteProveedor(
    ProveedorDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProveedorInProgress(),
    );
    try {
      await service.deleteProveedor(
        id: event.id,
      );
      emit(
        ProveedorDeletedSuccess(),
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
          ProveedorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
