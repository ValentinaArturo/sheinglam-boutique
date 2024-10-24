import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/productos/model/proveedor_list_model.dart';

class ProveedorService {
  Dio client;

  ProveedorService() : client = ClientFactory.buildClient();

  ProveedorService.withClient(
    this.client,
  );

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

  Future<Response<dynamic>> createProveedor({
    required String nombre,
    required String direccion,
    required String telefono,
    required String email,
    required String nit,
  }) async {
    return await client.post(
      proveedorPath,
      data: {
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "correoElectronico": email,
        "nit": nit,
      },
    );
  }

  Future<Response<dynamic>> updateProveedor({
    required int id,
    required String nombre,
    required String direccion,
    required String telefono,
    required String email,
    required String nit,
  }) async {
    return await client.post(
      '$proveedorPath$id',
      data: {
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "correoElectronico": email,
        "nit": nit,
      },
    );
  }

  Future<Response<dynamic>> deleteProveedor({
    required int id,
  }) async {
    return await client.delete(
      '$proveedorPath/$id',
    );
  }
}
