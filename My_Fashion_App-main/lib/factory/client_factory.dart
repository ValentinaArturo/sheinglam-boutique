import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/headers_interceptor.dart';
import 'package:my_fashion_app/resources/api_constants.dart';

class ClientFactory {
  static Dio buildClient() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (int? status) => status! <= 201,
      ),
    );

    dio.interceptors
      ..add(
        LogInterceptor(),
      )
      ..add(
        HeadersInterceptor(),
      );
    return dio;
  }
}
