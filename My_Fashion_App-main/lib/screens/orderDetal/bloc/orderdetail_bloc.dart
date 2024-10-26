import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/orderDetal/model/order_model.dart';
import 'package:my_fashion_app/screens/orderDetal/service/order_detail_service.dart';

part 'orderdetail_event.dart';
part 'orderdetail_state.dart';

class OrderdetailBloc extends Bloc<OrderdetailEvent, OrderdetailState> {
  OrderdetailBloc() : super(OrderdetailInitial()) {
    on<OrderDetailShown>(getOrderList);
  }

  final OrderDetailService service = OrderDetailService();

  Future<void> getOrderList(
    OrderDetailShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OrderInProgress(),
    );
    try {
      final OrderDetailListModel resp = await service.getOrderDetail(
        id: event.id,
      );
      emit(
        OrderDetailSuccess(detalle: resp),
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
