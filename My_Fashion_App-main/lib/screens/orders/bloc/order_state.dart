part of 'order_bloc.dart';

abstract class OrderState extends BaseState {}

class OrderInitial extends OrderState {}

class OrderInProgress extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderListModel> ordenes;

  OrderSuccess({
    required this.ordenes,
  });
}

class OrderError extends OrderState {
  final String message;

  OrderError({
    required this.message,
  });
}
