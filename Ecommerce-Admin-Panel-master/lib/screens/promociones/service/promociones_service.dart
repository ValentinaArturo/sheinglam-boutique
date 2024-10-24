import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/promociones/model/promociones_model.dart';

class PromocionService {
  Dio client;

  PromocionService() : client = ClientFactory.buildClient();

  PromocionService.withClient(
    this.client,
  );

  Future<List<PromocionListModel>> getPromocion() async {
    final response = await client.get(
      promocionPath,
    );
    return List<PromocionListModel>.from(
      response.data.map(
        (promocion) => PromocionListModel.fromJson(promocion),
      ),
    );
  }

  Future<Response<dynamic>> createPromocion({
    required String nombre,
    required String descripcion,
    required double descuento,
  }) async {
    return await client.post(
      promocionPath,
      data: {
        "nombre": nombre,
        "descripcion": descripcion,
        "descuento": descuento,
      },
    );
  }

  Future<Response<dynamic>> updatePromocion({
    required int id,
    required String nombre,
    required String descripcion,
    required double descuento,
  }) async {
    return await client.post(
      '$promocionPath$id',
      data: {
        "nombre": nombre,
        "descripcion": descripcion,
        "descuento": descuento,
      },
    );
  }

  Future<Response<dynamic>> deletePromocion({
    required int id,
  }) async {
    return await client.delete(
      '$promocionPath/$id',
    );
  }
}
