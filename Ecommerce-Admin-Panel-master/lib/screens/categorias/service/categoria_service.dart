import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';

class CategoriaService {
  Dio client;

  CategoriaService() : client = ClientFactory.buildClient();

  CategoriaService.withClient(
    this.client,
  );

  Future<List<CategoriaListModel>> getCategoria() async {
    final response = await client.get(
      categoriaPath,
    );
    return List<CategoriaListModel>.from(
      response.data.map(
        (categoria) => CategoriaListModel.fromJson(categoria),
      ),
    );
  }

  Future<Response<dynamic>> createCategoria({
    required String nombre,
  }) async {
    return await client.post(
      categoriaPath,
      data: {
        "nombre": nombre,
      },
    );
  }

  Future<Response<dynamic>> updateCategoria({
    required int id,
    required String nombre,
  }) async {
    return await client.put(
      '$categoriaPath/$id',
      data: {
        "nombre": nombre,
      },
    );
  }

  Future<Response<dynamic>> deleteCategoria({
    required int id,
  }) async {
    return await client.delete(
      '$categoriaPath/$id',
    );
  }
}
