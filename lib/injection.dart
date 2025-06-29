import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api_service.dart';
import 'features/weather/data/datasources/weather_remote_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: dotenv.get('BASE_URL', fallback: ''),
        headers: {'Content-Type': 'application/json'},
      ),
    ),
  );

  sl.registerLazySingleton<ApiService>(() => DioApiService(sl<Dio>()));

  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      api: sl<ApiService>(),
      apiKey: dotenv.get('OPENWEATHERMAP_API_KEY', fallback: ''),
    ),
  );
}
