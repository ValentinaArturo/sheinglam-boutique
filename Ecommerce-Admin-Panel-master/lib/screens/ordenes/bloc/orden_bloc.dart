import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/model/orden_list_model.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/service/orden_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'orden_event.dart';
part 'orden_state.dart';

class OrdenBloc extends Bloc<OrdenEvent, OrdenState> {
  OrdenBloc() : super(OrdenInitial()) {
    on<OrdenShown>(getOrden);
    on<OrdenEdited>(updateOrden);
    on<OrdenDeleted>(deleteOrden);
  }

  final OrdenService service = OrdenService();

  Future<void> getOrden(
    OrdenShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OrdenInProgress(),
    );
    try {
      final List<OrdenListModel> resp = await service.getOrden();
      emit(
        OrdenSuccess(ordenes: resp),
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
          OrdenError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateOrden(
    OrdenEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OrdenInProgress(),
    );
    try {
      await service.updateOrden(
        id: event.id,
        idPedido: event.idPedido,
        idEstadoPedido: event.idEstadoPedido,
        fecha: event.fecha,
      );
      emit(
        OrdenEditedSuccess(),
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
          OrdenError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteOrden(
    OrdenDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OrdenInProgress(),
    );
    try {
      await service.deleteOrden(
        id: event.id,
      );
      emit(
        OrdenDeletedSuccess(),
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
          OrdenError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
