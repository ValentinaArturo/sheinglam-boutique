import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/productDetail/model/imagen_producto_model.dart';
import 'package:my_fashion_app/screens/productos/model/categoria_list_model.dart';
import 'package:my_fashion_app/screens/productos/model/producto_list_model.dart';
import 'package:my_fashion_app/screens/productos/model/producto_promocion_model.dart';

class ProductoService {
  Dio client;

  ProductoService() : client = ClientFactory.buildClient();

  ProductoService.withClient(
    this.client,
  );

  Future<List<ImagenListModel>> getImagenProducto() async {
    final response = await client.get(
      imageProductoPath,
    );
    return List<ImagenListModel>.from(
      response.data.map((image) => ImagenListModel.fromJson(image))
    );
  }

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

  Future<List<CategoriaListModel>> getCategorias() async {
    final response = await client.get(
      categoriaPath,
    );
    return List<CategoriaListModel>.from(
      response.data.map(
        (categoria) => CategoriaListModel.fromJson(categoria),
      ),
    );
  }

  Future<List<ProductoPromocionListModel>> getProductoPromocion() async {
    final response = await client.get(
      productoPromocionPath,
    );
    return List<ProductoPromocionListModel>.from(
      response.data.map(
        (producto) => ProductoPromocionListModel.fromJson(producto),
      ),
    );
  }
}
