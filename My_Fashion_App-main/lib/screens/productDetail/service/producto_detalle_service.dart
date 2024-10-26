import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/productDetail/model/carrito_list_model.dart';
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

  Future<CarritoListModel> getCarritoById({
    required int id,
  }) async {
    final response = await client.get(
      '$carritoPath/$id',
    );
    return CarritoListModel.fromJson(response.data);
  }

  Future<Response<dynamic>> crearCarrito({
    required int idCliente,
  }) async {
    return await client.post(
      carritoPath,
      data: {
        "cliente": {
          "id": idCliente,
        }
      },
    );
  }

  Future<Response<dynamic>> agregarCarrito({
    required int idCarrito,
    required int idProducto,
    required int cantidad,
  }) async {
    return await client.post(
      carritoProductoPath,
      data: {
        "carrito": {
          "idCarrito": idCarrito,
        },
        "producto": {
          "idProducto": idProducto,
        },
        "cantidad": cantidad,
      },
    );
  }

  Future<Response<dynamic>> editarCarrito({
    required int id,
    required int idCarrito,
    required int idProducto,
    required int cantidad,
  }) async {
    return await client.put(
      '$carritoProductoPath/$id',
      data: {
        "carrito": {
          "idCarrito": idCarrito,
        },
        "producto": {
          "idProducto": idProducto,
        },
        "cantidad": cantidad,
      },
    );
  }
}
