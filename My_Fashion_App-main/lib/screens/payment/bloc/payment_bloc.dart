import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/payment/model/direccion_envio_model.dart';
import 'package:my_fashion_app/screens/payment/model/envio_model.dart';
import 'package:my_fashion_app/screens/payment/service/payment_service.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<DireccionEnvioShown>(getDireccionEnvios);
    on<EnvioShown>(getEnvio);
    on<PedidoCreated>(createPedido);
    on<DetallePedidoCreated>(createDetallePedido);
    on<EstadoPedidoCreated>(createEstadoPedido);
    on<EnvioCreated>(createEnvio);
    on<FacturaCreated>(createFactura);
    on<FacturaDetalleCreated>(createDetalleFactura);
  }

  final PaymentService service = PaymentService();

  Future<void> getDireccionEnvios(
    DireccionEnvioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      final List<DireccionEnvioListModel> resp =
          await service.getDireccionEnvio(
        idCliente: event.idCliente,
      );
      emit(
        DireccionEnvioObtainedSuccess(direccionEnvio: resp),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getEnvio(
    EnvioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      final EnvioModel resp = await service.getEnvio(
        idDepartamento: event.idDepartamento,
      );
      emit(
        EnvioObtainedSuccess(envioModel: resp),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createPedido(
    PedidoCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createPedido(
        idCliente: event.idCliente,
        idMetodoPago: event.idMetodoPago,
        fecha: event.fecha,
        total: event.total,
        nit: event.nit,
      );
      emit(
        PedidoCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createDetallePedido(
    DetallePedidoCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createDetallePedido(
        idPedido: event.idPedido,
        idProducto: event.idProducto,
        cantidad: event.cantidad,
        precio: event.precio,
        subTotal: event.subTotal,
      );
      emit(
        DetallePedidoCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createEstadoPedido(
    EstadoPedidoCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createEstadoPedido(
        estado: event.estado,
      );
      emit(
        EstadoPedidoCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createEnvio(
    EnvioCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createEnvio(
        idPedido: event.idPedido,
        metodoEnvio: event.metodoEnvio,
        costoEnvio: event.costoEnvio,
        fechaEnvio: event.fechaEnvio,
      );
      emit(
        EnvioCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createFactura(
    FacturaCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createFactura(
        idPedido: event.idPedido,
        total: event.total,
        fecha: event.fecha,
      );
      emit(
        FacturaCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createDetalleFactura(
    FacturaDetalleCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PaymentInProgress(),
    );
    try {
      await service.createDetalleFactura(
        idFactura: event.idFactura,
        idProducto: event.idProducto,
        cantidad: event.cantidad,
        precioUntario: event.precioUntario,
        subTotal: event.subTotal,
      );
      emit(
        DetalleFacturaCreatedSuccess(),
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
          PaymentError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
