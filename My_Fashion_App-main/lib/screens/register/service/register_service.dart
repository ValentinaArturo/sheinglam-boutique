import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/register/model/address_model.dart';
import 'package:my_fashion_app/screens/register/model/cliente_model.dart';

class RegisterService {
  Dio guess;

  RegisterService() : guess = GuessFactory.buildClient();

  RegisterService.withClient(
    this.guess,
  );

  Future<Response> registerUser({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required int idRol,
  }) async {
    return await guess.post(
      usuarioPath,
      data: {
        "nombre": name,
        "apellido": lastName,
        "correoElectronico": email,
        "contraseña": password,
        "rol": {
          "idRol": idRol,
        }
      },
    );
  }

  Future<Response> updateUser({
    required int id,
    required String name,
    required String lastName,
    required String email,
    required int idRol,
    required String password,
  }) async {
    return await guess.post(
      '$usuarioPath$id',
      data: {
        "nombre": name,
        "apellido": lastName,
        "correoElectronico": email,
        "contraseña": password,
        "rol": {
          "idRol": idRol,
        }
      },
    );
  }

  Future<List<ClienteListModel>> getClientes() async {
    final resp = await guess.get(
      clientePath,
    );
    return List<ClienteListModel>.from(
      resp.data.map(
        (cliente) => ClienteListModel.fromJson(cliente),
      ),
    );
  }

  Future<List<AddressListModel>> getAddress() async {
    final resp = await guess.get(
      addressPath,
    );
    return List<AddressListModel>.from(
      resp.data.map(
        (cliente) => AddressListModel.fromJson(cliente),
      ),
    );
  }
}
