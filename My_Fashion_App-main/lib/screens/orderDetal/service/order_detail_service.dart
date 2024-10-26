import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/orderDetal/model/order_model.dart';

class OrderDetailService {
  Dio client;

  OrderDetailService() : client = ClientFactory.buildClient();

  OrderDetailService.withClient(
    this.client,
  );

  Future<OrderDetailListModel> getOrderDetail({
    required int id,
  }) async {
    final response = await client.get(
      '$detallePedidoPath/$id',
    );
    return OrderDetailListModel.fromJson(response.data);
  }
}
