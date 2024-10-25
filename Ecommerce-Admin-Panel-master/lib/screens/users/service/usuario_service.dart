import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/client_factory.dart';
import 'package:ecommerce_admin_panel/repository/repository_constants.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';
import 'package:ecommerce_admin_panel/screens/users/model/ciudad_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/cliente_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/direccion_list_model.dart';
import 'package:ecommerce_admin_panel/screens/users/model/rol_model_list.dart';

class UsuarioService {
  Dio client;

  UsuarioService() : client = ClientFactory.buildClient();

  UsuarioService.withClient(
    this.client,
  );

  Future<List<ClientListModel>> getUsuario() async {
    final response = await client.get(
      clientePath,
    );
    return List<ClientListModel>.from(
      response.data.map(
        (usuario) => ClientListModel.fromJson(usuario),
      ),
    );
  }

  Future<List<CiudadListModel>> getCiudad() async {
    final response = await client.get(
      ciudadPath,
    );
    return List<CiudadListModel>.from(
      response.data.map(
        (ciudad) => CiudadListModel.fromJson(ciudad),
      ),
    );
  }

  Future<List<RolListmodel>> getRoles() async {
    final response = await client.get(
      rolesPath,
    );
    return List<RolListmodel>.from(
      response.data.map(
        (ciudad) => RolListmodel.fromJson(ciudad),
      ),
    );
  }

  Future<Response<dynamic>> createCliente({
    required String nombre,
    required String apellido,
    required String correoElectronico,
    required String password,
    required String address,
    required String phone,
    required String postal,
    required int ciudad,
    required int rol,
  }) async {
    return await client.post(clientePath, data: {
      "usuario": {
        "nombre": nombre,
        "apellido": apellido,
        "correoElectronico": correoElectronico,
        "contraseña": password,
        "rol": {
          "idRol": rol,
        }
      },
      "cliente": {
        "direccion": address,
        "telefono": phone,
      },
      "direccionEnvio": {
        "direccion": address,
        "codigoPostal": postal,
        "pais": {
          "idPais": 1,
        },
        "ciudad": {
          "idCiudad": ciudad,
        }
      }
    });
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

  Future<Response<dynamic>> createDireccionEnvio({
    required int idCliente,
    required String direccion,
    required int idCiudad,
    required String codigoPostal,
    required int idPais,
  }) async {
    return await client.post(
      direccionEnvioPath,
      data: {
        "cliente": {
          "idCliente": idCliente,
        },
        "direccion": direccion,
        "ciudad": {
          "idCiudad": idCiudad,
        },
        "codigoPostal": codigoPostal,
        "pais": {
          "idPais": idPais,
        }
      },
    );
  }

  Future<List<DireccionEnvioListModel>> getDireccionesEnvio() async {
    final response = await client.get(
      direccionEnvioPath,
    );
    return List<DireccionEnvioListModel>.from(
      response.data.map(
            (ciudad) => DireccionEnvioListModel.fromJson(ciudad),
      ),
    );
  }

  Future<Response<dynamic>> editDireccionEnvio({
    required int id,
    required int idCliente,
    required String direccion,
    required int idCiudad,
    required String codigoPostal,
    required int idPais,
  }) async {
    return await client.post(
      '$direccionEnvioPath/$id',
      data: {
        "cliente": {
          "idCliente": idCliente,
        },
        "direccion": direccion,
        "ciudad": {
          "idCiudad": idCiudad,
        },
        "codigoPostal": codigoPostal,
        "pais": {
          "idPais": idPais,
        }
      },
    );
  }
}
