import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';

class RegisterService {
  Dio guess;

  RegisterService() : guess = GuessFactory.buildClient();

  RegisterService.withClient(
    this.guess,
  );

  Future<Response> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return await guess.post(
      usuarioPath,
      data: {
        "nombre": name.split(' ')[0],
        "apellido": name.split(' ')[1],
        "correoElectronico": email,
        "contraseña": password,
        "rol": {"idRol": 1}
      },
    );
  }
}
