import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters});
}

class DioApiService implements ApiService {
  final Dio dio;

  DioApiService(this.dio);

  @override
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) {
    return dio.get(url, queryParameters: queryParameters);
  }
}
