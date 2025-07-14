import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';

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
      apiService: sl<ApiService>(),
      apiKey: dotenv.get('OPENWEATHERMAP_API_KEY', fallback: ''),
    ),
  );

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl()),
  );

  sl.registerFactory<WeatherCubit>(() => WeatherCubit(sl<WeatherRepository>()));
}
