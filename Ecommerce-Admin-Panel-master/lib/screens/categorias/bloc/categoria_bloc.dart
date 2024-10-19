import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:ecommerce_admin_panel/screens/categorias/service/categoria_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categoria_event.dart';
part 'categoria_state.dart';

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriaState> {
  CategoriaBloc() : super(CategoriaInitial()) {
    on<CategoriaShown>(getCategoria);
    on<CategoriaSaved>(createCategoria);
    on<CategoriaEdited>(updateCategoria);
    on<CategoriaDeleted>(deleteCategoria);
  }

  final CategoriaService service = CategoriaService();

  Future<void> getCategoria(
    CategoriaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CategoriaInProgress(),
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
          CategoriaError(
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
      CategoriaInProgress(),
    );
    try {
      await service.createCategoria(
        nombre: event.nombre,
      );
      emit(
        CategoriaCreatedSuccess(),
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
          CategoriaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateCategoria(
    CategoriaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CategoriaInProgress(),
    );
    try {
      await service.updateCategoria(
        nombre: event.nombre,
        id: event.id,
      );
      emit(
        CategoriaEditedSuccess(),
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
          CategoriaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteCategoria(
    CategoriaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CategoriaInProgress(),
    );
    try {
      await service.deleteCategoria(
        id: event.id,
      );
      emit(
        CategoriaDeletedSuccess(),
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
          CategoriaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
