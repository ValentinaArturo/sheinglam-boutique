import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/resources/constants.dart';
import 'package:ecommerce_admin_panel/screens/shipment/model/shipment_list_model.dart';
import 'package:ecommerce_admin_panel/screens/shipment/service/shipment_service.dart';
import 'package:equatable/equatable.dart';

import '../model/detalle_factura_list_model.dart';
import '../model/factura_list_model.dart';

part 'shipment_event.dart';
part 'shipment_state.dart';

class ShipmentBloc extends Bloc<ShipmentEvent, ShipmentState> {
  ShipmentBloc() : super(ShipmentInitial()) {
    on<FacturasShown>(getFacturas);
    on<DetalleFacturasShown>(getDetalleFacturas);
  }

  final ShipmentService service = ShipmentService();

  Future<void> getFacturas(
    FacturasShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ShipmentInProgress(),
    );
    try {
      final List<FacturaListModel> resp = await service.getFacturas();
      emit(
        ShipmentFacturaSuccess(facturas: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ShipmentPedidosError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getDetalleFacturas(
    DetalleFacturasShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ShipmentInProgress(),
    );
    try {
      final List<DetalleFacturaListModel> resp =
          await service.getDetalleFacturas();
      emit(
        ShipmentDetalleFacturaSuccess(detalleFacturas: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ShipmentPedidosError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
