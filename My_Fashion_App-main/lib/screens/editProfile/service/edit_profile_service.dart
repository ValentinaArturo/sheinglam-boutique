import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/editProfile/model/edit_profile_model.dart';
import 'package:my_fashion_app/screens/editProfile/model/profile_model.dart';

class EditProfileService {
  Dio guess;
  Dio client;

  EditProfileService()
      : guess = GuessFactory.buildClient(),
        client = ClientFactory.buildClient();

  EditProfileService.withClient(
    this.guess,
    this.client,
  );

  Future<PerfilModel> getProfile({
    required int id,
  }) async {
    final resp = await client.get(
      '$clientePath/$id',
    );
    return PerfilModel.fromJson(resp.data);
  }

  Future<Response> editProfile({
    required int id,
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String direccion,
    required String telefono,
    required String direccionEnvio,
    required String codigoPostal,
    required int idCiudad,
    required int idPais,
  }) async {
    return await client.put(
      '$clientePath/$id',
      data: {
        "usuario": {
          "nombre": name,
          "apellido": lastName,
          "correoElectronico": email,
          "contraseña": password
        },
        "cliente": {
          "direccion": direccion,
          "telefono": telefono,
        },
        "direccionEnvio": {
          "direccion": direccionEnvio,
          "codigoPostal": codigoPostal
        },
        "ciudad": {
          "idCiudad": idCiudad,
        },
        "pais": {
          "idPais": idPais,
        }
      },
    );
  }

  Future<AddressListModel> getUserAddress({
    required int id,
  }) async {
    final resp = await client.get(
      '$addressPath/9',
    );
    return AddressListModel.fromJson(resp.data);
  }

  Future<Response> updateDireccionEnvio() async {
    return await client.put(
      '$addressPath/9',
      data: {
        "cliente": {
          "idCliente": 2,
        },
        "direccion": "123 Calle Ejemplo",
        "ciudad": {
          "idCiudad": 1,
        },
        "codigoPostal": "01010",
        "pais": {
          "idPais": 1,
        }
      },
    );
  }
}
