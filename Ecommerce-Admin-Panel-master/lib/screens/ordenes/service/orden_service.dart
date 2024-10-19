import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/ordenes/model/orden_list_model.dart';

class OrdenService {
  Dio client;

  OrdenService() : client = ClientFactory.buildClient();

  OrdenService.withClient(
    this.client,
  );

  Future<List<OrdenListModel>> getOrden() async {
    final response = await client.get(
      pedidoPath,
    );
    return List<OrdenListModel>.from(
      response.data.map(
        (pedido) => OrdenListModel.fromJson(pedido),
      ),
    );
  }

  Future<Response<dynamic>> updateOrden({
    required int id,
    required int idPedido,
    required int idEstadoPedido,
    required String fecha,
  }) async {
    return await client.put(
      '$pedidoPath/$id',
      data: {
        "pedido": {
          "idPedido": idPedido,
        },
        "estadoPedido": {
          "idEstadoPedido": idEstadoPedido,
        },
        "fecha": fecha,
      },
    );
  }

  Future<Response<dynamic>> deleteOrden({
    required int id,
  }) async {
    return await client.delete(
      '$pedidoPath/$id',
    );
  }
}
