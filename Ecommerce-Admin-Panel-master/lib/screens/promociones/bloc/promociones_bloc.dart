import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/promociones/model/promociones_model.dart';
import 'package:ecommerce_admin_panel/screens/promociones/service/promociones_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promociones_event.dart';
part 'promociones_state.dart';

class PromocionesBloc extends Bloc<PromocionesEvent, PromocionesState> {
  PromocionesBloc() : super(PromocionesInitial()) {
    on<PromocionesShown>(getPromociones);
    on<PromocionesCreated>(createPromociones);
    on<PromocionesEdited>(editPromociones);
    on<PromocionesDeleted>(deletePromociones);
  }

  final PromocionService service = PromocionService();

  Future<void> getPromociones(
    PromocionesShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PromocionesInProgress(),
    );
    try {
      final List<PromocionListModel> resp = await service.getPromocion();
      emit(
        PromocionesListSuccess(promociones: resp),
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
          PromocionesError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createPromociones(
    PromocionesCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PromocionesInProgress(),
    );
    try {
      await service.createPromocion(
        nombre: event.nombre,
        descripcion: event.descripcion,
        descuento: event.descuento,
      );
      emit(
        PromocionesCreatedSuccess(),
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
          PromocionesError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> editPromociones(
    PromocionesEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PromocionesInProgress(),
    );
    try {
      await service.updatePromocion(
        id: event.id,
        nombre: event.nombre,
        descripcion: event.descripcion,
        descuento: event.descuento,
      );
      emit(
        PromocionesEditedSuccess(),
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
          PromocionesError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deletePromociones(
    PromocionesDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PromocionesInProgress(),
    );
    try {
      await service.deletePromocion(
        id: event.id,
      );
      emit(
        PromocionesDeletedSuccess(),
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
          PromocionesError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
