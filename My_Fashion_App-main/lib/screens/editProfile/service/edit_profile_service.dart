import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/editProfile/model/edit_profile_model.dart';

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

  Future<Response> editProfile({
    required int id,
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String direccion,
    required String telefono,
  }) async {
    return await guess.post(
      '$clientePath$id',
      data: {
        "usuario": {
          "nombre": name,
          "apellido": lastName,
          "correoElectronico": email,
          "contraseña": password,
        },
        "direccion": direccion,
        "telefono": telefono,
      },
    );
  }

  Future<AddressListModel> getUserAddress({
    required int id,
  }) async {
    final resp = await client.get(
      addressPath,
    );
    return AddressListModel.fromJson(resp.data);
  }
}
