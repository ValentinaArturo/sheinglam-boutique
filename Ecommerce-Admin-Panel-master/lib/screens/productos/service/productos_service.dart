import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/categorias/model/categoria_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/color_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/imagen_producto_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/producto_promocion_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/talla_list_model.dart';

class ProductoService {
  Dio client;

  ProductoService() : client = ClientFactory.buildClient();

  ProductoService.withClient(
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

  Future<List<ProductoPromocionListModel>> getProductoPromocion() async {
    final response = await client.get(
      productosPromocionesPath,
    );
    return List<ProductoPromocionListModel>.from(
      response.data.map(
        (productoPromocion) =>
            ProductoPromocionListModel.fromJson(productoPromocion),
      ),
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

  Future<List<TallaListModel>> getTalla() async {
    final response = await client.get(
      tallaPath,
    );
    return List<TallaListModel>.from(
      response.data.map(
        (talla) => TallaListModel.fromJson(talla),
      ),
    );
  }

  Future<List<ProveedorListModel>> getProveedor() async {
    final response = await client.get(
      proveedorPath,
    );
    return List<ProveedorListModel>.from(
      response.data.map(
        (proveedor) => ProveedorListModel.fromJson(proveedor),
      ),
    );
  }

  Future<List<ColorListModel>> getColor() async {
    final response = await client.get(
      colorPath,
    );
    return List<ColorListModel>.from(
      response.data.map(
        (color) => ColorListModel.fromJson(color),
      ),
    );
  }

  Future<List<ImagenProductoModel>> getImagenProducto() async {
    final response = await client.get(
      imagenProductoPath,
    );
    return List<ImagenProductoModel>.from(
      response.data.map(
        (imagen) => ImagenProductoModel.fromJson(imagen),
      ),
    );
  }

  Future<ImagenProductoModel> getImagenProductoId({
    required int id,
  }) async {
    final response = await client.get(
      '$imagenProductoPath/$id',
    );
    return ImagenProductoModel.fromJson(response.data);
  }

  Future<Response<dynamic>> createCategoriaProducto({
    required int idProducto,
    required int idCategoria,
  }) async {
    return await client.post(
      categoriaProductoPath,
      data: {
        "producto": {
          "idProducto": idProducto,
        },
        "categoria": {
          "idCategoria": idCategoria,
        }
      },
    );
  }

  Future<Response<dynamic>> createProductoPromocion({
    required int idProducto,
    required int idPromocion,
  }) async {
    return await client.post(
      productosPromocionesPath,
      data: {
        "producto": {
          "idProducto": idProducto,
        },
        "promocion": {
          "idPromocion": idPromocion,
        }
      },
    );
  }

  Future<ImagenProductoModel> createImagenProducto({
    required int idProducto,
    required String imagenProducto,
  }) async {
    final response = await client.post(
      imagenProductoPath,
      data: {
        "imagenProducto": imagenProducto,
        "producto": {
          "id": idProducto,
        }
      },
    );
    return ImagenProductoModel.fromJson(response.data);
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
