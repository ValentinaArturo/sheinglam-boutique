import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/cart/model/cart_model.dart';

class CartService {
  Dio guess;

  CartService() : guess = ClientFactory.buildClient();

  CartService.withClient(
    this.guess,
  );

  Future<List<CartListModel>> getCart() async {
    final resp = await guess.get(
      carritoPath,
    );
    return List<CartListModel>.from(
      resp.data.map(
        (cart) => CartListModel.fromJson(cart),
      ),
    );
  }
}
