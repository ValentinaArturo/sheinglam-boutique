part of 'payment_bloc.dart';

abstract class PaymentState extends BaseState {}

class PaymentInitial extends PaymentState {}

class PaymentInProgress extends PaymentState {}

class DireccionEnvioObtainedSuccess extends PaymentState {
  final List<DireccionEnvioListModel> direccionEnvio;

  DireccionEnvioObtainedSuccess({
    required this.direccionEnvio,
  });
}

class EnvioObtainedSuccess extends PaymentState {
  final EnvioModel envioModel;
  EnvioObtainedSuccess({
    required this.envioModel,
  });
}

class PedidoCreatedSuccess extends PaymentState {}

class DetallePedidoCreatedSuccess extends PaymentState {}

class EstadoPedidoCreatedSuccess extends PaymentState {}

class EnvioCreatedSuccess extends PaymentState {}

class FacturaCreatedSuccess extends PaymentState {}

class DetalleFacturaCreatedSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({
    required this.message,
  });
}
