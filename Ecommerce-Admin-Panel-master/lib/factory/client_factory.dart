import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/factory/headers_interceptor.dart';
import 'package:ecommerce_admin_panel/resources/api_constants.dart';

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
