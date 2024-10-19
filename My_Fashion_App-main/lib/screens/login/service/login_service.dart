import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/guess_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/login/model/login_model.dart';

class LoginService {
  Dio guess;

  LoginService() : guess = GuessFactory.buildClient();

  LoginService.withClient(
      this.guess,
      );

  Future<LoginModel> authUser({
    required String username,
    required String password,
  }) async {
    final response = await guess.post(
      authPath,
      queryParameters: {
        'email': username,
        'password': password,
      },
    );
    return LoginModel.fromJson(response.data);
  }
}
