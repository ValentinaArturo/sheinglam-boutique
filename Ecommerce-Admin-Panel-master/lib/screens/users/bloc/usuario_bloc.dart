import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/users/model/usuario_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/service/usuario_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  UsuarioBloc() : super(UsuarioInitial()) {
    on<UsuarioShown>(getUsuario);
    on<UsuarioSaved>(createUsuario);
    on<UsuarioEdited>(updateUsuario);
    on<UsuarioDeleted>(deleteUsuario);
  }

  final UsuarioService service = UsuarioService();

  Future<void> getUsuario(
    UsuarioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      UsuarioInProgress(),
    );
    try {
      final List<UsuarioListModel> resp = await service.getUsuario();
      emit(
        UsuarioSuccess(usuarios: resp),
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
          UsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createUsuario(
    UsuarioSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      UsuarioInProgress(),
    );
    try {
      await service.createUsuario(
        nombre: event.nombre,
        apellido: event.apellido,
        correoElectronico: event.correoElectronico,
        password: event.password,
        rol: event.rol,
      );
      emit(
        UsuarioCreatedSuccess(),
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
          UsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateUsuario(
    UsuarioEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      UsuarioInProgress(),
    );
    try {
      await service.updateUsuario(
        nombre: event.nombre,
        apellido: event.apellido,
        correoElectronico: event.correoElectronico,
        password: event.password,
        rol: event.rol,
        id: event.id,
      );
      emit(
        UsuarioEditedSuccess(),
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
          UsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteUsuario(
    UsuarioDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      UsuarioInProgress(),
    );
    try {
      await service.deleteUsuario(
        id: event.id,
      );
      emit(
        UsuarioDeletedSuccess(),
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
          UsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
