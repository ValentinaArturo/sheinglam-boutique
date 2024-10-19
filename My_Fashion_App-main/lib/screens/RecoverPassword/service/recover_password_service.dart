import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';

class RecoveredService {
  Dio guess;

  RecoveredService() : guess = GuessFactory.buildClient();

  RecoveredService.withClient(
    this.guess,
  );

  Future<Response> recoverPassword({
    required String email,
  }) async {
    return await guess.post(
      usuarioPath,
      data: {},
    );
  }
}
