import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';

import 'headers_interceptor.dart';

class GuessFactory {
  static Dio buildClient() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (int? status) => status! <= 200,
      ),
    );

    dio.interceptors
      ..add(
        LogInterceptor(),
      )
      ..add(
        HeadersInterceptor(
          isGuess: true,
        ),
      );
    return dio;
  }
}
