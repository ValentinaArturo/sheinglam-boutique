import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/orders/model/order_list_model.dart';

class OrderService {
  Dio client;

  OrderService() : client = ClientFactory.buildClient();

  OrderService.withClient(
    this.client,
  );

  Future<List<OrderListModel>> getOrders() async {
    final response = await client.get(
      pedidoPath,
    );
    return List<OrderListModel>.from(
      response.data.map(
        (order) => OrderListModel.fromJson(order),
      ),
    );
  }
}
