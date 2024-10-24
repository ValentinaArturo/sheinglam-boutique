import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/returns/model/return_model.dart';

class ReturnService {
  Dio client;

  ReturnService() : client = ClientFactory.buildClient();

  ReturnService.withClient(
    this.client,
  );

  Future<List<ReturnListModel>> getReturn() async {
    final response = await client.get(
      returnsPath,
    );
    return List<ReturnListModel>.from(
      response.data.map(
        (returns) => ReturnListModel.fromJson(returns),
      ),
    );
  }

  Future<Response<dynamic>> createReturn({
    required int idPedido,
    required String motivo,
    required String fechaDevolucion,
    required String estado,
  }) async {
    return await client.post(
      returnsPath,
      data: {
        "pedido": {
          "idPedido": idPedido,
        },
        "motivo": motivo,
        "fechaDevolucion": fechaDevolucion,
        "estado": estado,
      },
    );
  }

  Future<Response<dynamic>> updateReturn({
    required int id,
    required int idPedido,
    required String motivo,
    required String fechaDevolucion,
    required String estado,
  }) async {
    return await client.post(
      returnsPath,
      data: {
        "pedido": {
          "idPedido": idPedido,
        },
        "motivo": motivo,
        "fechaDevolucion": fechaDevolucion,
        "estado": estado,
      },
    );
  }

  Future<Response<dynamic>> deleteReturn({
    required int id,
  }) async {
    return await client.delete(
      '$returnsPath/$id',
    );
  }
}
