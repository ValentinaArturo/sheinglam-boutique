import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/returns/model/return_model.dart';
import 'package:ecommerce_admin_panel/screens/returns/service/return_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'return_event.dart';
part 'return_state.dart';

class ReturnBloc extends Bloc<ReturnEvent, ReturnState> {
  ReturnBloc() : super(ReturnInitial()) {
    on<ReturnShown>(getReturn);
    on<ReturnCreated>(createReturn);
    on<ReturnEdited>(editReturn);
    on<ReturnDeleted>(deleteReturn);
  }

  final ReturnService service = ReturnService();

  Future<void> getReturn(
    ReturnShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ReturnInProgress(),
    );
    try {
      final List<ReturnListModel> resp = await service.getReturn();
      emit(
        ReturnListSuccess(proveedores: resp),
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
          ReturnError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createReturn(
    ReturnCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ReturnInProgress(),
    );
    try {
      await service.createReturn(
        idPedido: event.idPedido,
        motivo: event.motivo,
        fechaDevolucion: event.fechaDevolucion,
        estado: event.estado,
      );
      emit(
        ReturnCreatedSuccess(),
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
          ReturnError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> editReturn(
    ReturnEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ReturnInProgress(),
    );
    try {
      await service.updateReturn(
        id: event.id,
        idPedido: event.idPedido,
        motivo: event.motivo,
        fechaDevolucion: event.fechaDevolucion,
        estado: event.estado,
      );
      emit(
        ReturnEditedSuccess(),
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
          ReturnError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteReturn(
    ReturnDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ReturnInProgress(),
    );
    try {
      await service.deleteReturn(
        id: event.id,
      );
      emit(
        ReturnDeletedSuccess(),
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
          ReturnError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
