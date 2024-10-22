import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/orders/model/order_list_model.dart';
import 'package:my_fashion_app/screens/orders/service/order_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderShown>(getOrderList);
  }

  final OrderService service = OrderService();

  Future<void> getOrderList(
    OrderShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OrderInProgress(),
    );
    try {
      final List<OrderListModel> resp = await service.getOrders();
      emit(
        OrderSuccess(ordenes: resp),
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
          OrderError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
