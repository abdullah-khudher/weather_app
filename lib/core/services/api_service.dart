import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  });
}

class DioApiService implements ApiService {
  final Dio dio;

  DioApiService(this.dio);

  @override
  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(endPoint, queryParameters: queryParameters);
    return response.data;
  }
}
