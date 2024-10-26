part of 'orderdetail_bloc.dart';

abstract class OrderdetailState extends BaseState {}

class OrderdetailInitial extends OrderdetailState {}

class OrderInProgress extends OrderdetailState {}

class OrderDetailSuccess extends OrderdetailState {
  final OrderDetailListModel detalle;

  OrderDetailSuccess({
    required this.detalle,
  });
}

class OrderError extends OrderdetailState {
  final String message;

  OrderError({
    required this.message,
  });
}
