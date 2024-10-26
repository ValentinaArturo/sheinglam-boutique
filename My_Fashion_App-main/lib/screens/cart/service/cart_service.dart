import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';

class CartService {
  Dio client;

  CartService() : client = ClientFactory.buildClient();

  CartService.withClient(
    this.client,
  );

  Future<List<CartListModel>> getCart() async {
    final resp = await client.get(
      carritoProductoPath,
    );
    return List<CartListModel>.from(
      resp.data.map(
        (cart) => CartListModel.fromJson(cart),
      ),
    );
  }

  Future<List<ImagenListModel>> getImagenProducto() async {
    final response = await client.get(
      imageProductoPath,
    );
    return List<ImagenListModel>.from(
      response.data.map(
        (image) => ImagenListModel.fromJson(image),
      ),
    );
  }
}
