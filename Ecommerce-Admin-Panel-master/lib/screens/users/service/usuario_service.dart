import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/users/model/usuario_list_model.dart';

class UsuarioService {
  Dio client;

  UsuarioService() : client = ClientFactory.buildClient();

  UsuarioService.withClient(
    this.client,
  );

  Future<List<UsuarioListModel>> getUsuario() async {
    final response = await client.get(
      usuarioPath,
    );
    return List<UsuarioListModel>.from(
      response.data.map(
        (usuario) => UsuarioListModel.fromJson(usuario),
      ),
    );
  }

  Future<Response<dynamic>> createUsuario({
    required String nombre,
    required String apellido,
    required String correoElectronico,
    required String password,
    required int rol,
  }) async {
    return await client.post(
      usuarioPath,
      data: {
        "nombre": nombre,
        "apellido": apellido,
        "correoElectronico": correoElectronico,
        "contraseña": password,
        "rol": {
          "idRol": rol,
        }
      },
    );
  }

  Future<Response<dynamic>> updateUsuario({
    required int id,
    required String nombre,
    required String apellido,
    required String correoElectronico,
    required String password,
    required int rol,
  }) async {
    return await client.put(
      '$usuarioPath/$id',
      data: {
        "nombre": nombre,
        "apellido": apellido,
        "correoElectronico": correoElectronico,
        "contraseña": password,
        "rol": {
          "idRol": rol,
        }
      },
    );
  }

  Future<Response<dynamic>> deleteUsuario({
    required int id,
  }) async {
    return await client.delete(
      '$usuarioPath/$id',
    );
  }
}
