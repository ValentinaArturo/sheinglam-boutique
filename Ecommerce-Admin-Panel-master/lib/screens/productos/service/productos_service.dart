import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';

class ProductoService {
  Dio client;

  ProductoService() : client = ClientFactory.buildClient();

  ProductoService.withClient(
    this.client,
  );

  Future<List<ProductoListModel>> getProducto() async {
    final response = await client.get(
      productoPath,
    );
    return List<ProductoListModel>.from(
      response.data.map(
        (producto) => ProductoListModel.fromJson(producto),
      ),
    );
  }

  Future<Response<dynamic>> createProducto({
    required String nombre,
    required String descripcion,
    required double precio,
    required int idTalla,
    required int idColor,
    required int stock,
    required int idProveedor,
  }) async {
    return await client.post(
      productoPath,
      data: {
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "talla": {
          "idTalla": idTalla,
        },
        "color": {
          "idColor": idColor,
        },
        "stock": stock,
        "proveedor": {
          "idProveedor": idProveedor,
        }
      },
    );
  }

  Future<Response<dynamic>> updateProducto({
    required int id,
    required String nombre,
    required String descripcion,
    required double precio,
    required int idTalla,
    required int idColor,
    required int stock,
    required int idProveedor,
  }) async {
    return await client.put(
      '$productoPath/$id',
      data: {
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "talla": {
          "idTalla": idTalla,
        },
        "color": {
          "idColor": idColor,
        },
        "stock": stock,
        "proveedor": {
          "idProveedor": idProveedor,
        }
      },
    );
  }

  Future<Response<dynamic>> deleteProducto({
    required int id,
  }) async {
    return await client.delete(
      '$productoPath/$id',
    );
  }
}
