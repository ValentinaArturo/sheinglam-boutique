import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';

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
}
