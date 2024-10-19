import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';

class ProductoDetalleService {
  Dio client;

  ProductoDetalleService() : client = ClientFactory.buildClient();

  ProductoDetalleService.withClient(
    this.client,
  );

  Future<ImagenListModel> getImagenProducto({
    required int productoId,
  }) async {
    final response = await client.get(
      '$imageProductoPath/$productoId',
    );
    return ImagenListModel.fromJson(response.data);
  }

  Future<Response<dynamic>> agregarCarrito({
    required int idCarrito,
    required int idProducto,
    required int cantidad,
  }) async {
    return await client.post(
      productoPath,
      data: {
        "carrito": {"idCarrito": idCarrito},
        "producto": {"idProducto": idProducto},
        "cantidad": cantidad,
      },
    );
  }
}
