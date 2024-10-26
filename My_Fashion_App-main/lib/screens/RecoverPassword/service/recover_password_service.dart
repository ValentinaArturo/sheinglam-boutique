import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';

class RecoveredService {
  Dio guess;

  RecoveredService() : guess = GuessFactory.buildClient();

  RecoveredService.withClient(
    this.guess,
  );

  Future<Response> sendPinViaEmail({
    required String email,
  }) async {
    return await guess.post(
      sendPinPath,
      queryParameters: {
        'email': email,
      },
    );
  }

  Future<Response> validatePin({
    required String email,
    required String pin,
  }) async {
    return await guess.post(
      validatePinPath,
      queryParameters: {
        'email': email,
        'pin': pin,
      },
    );
  }

  Future<Response> updatePassword({
    required String email,
    required String password,
  }) async {
    return await guess.put(
      '$usuarioPath/update-password',
      queryParameters: {
        "email": email,
        "password": password,
      },
    );
  }
}
