import 'package:weather_app/core/services/api_service.dart';

abstract class WeatherRemoteDataSource {
  Future<Map<String, dynamic>> getForecast(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiService api;
  final String apiKey;

  WeatherRemoteDataSourceImpl({required this.api, required this.apiKey});

  @override
  Future<Map<String, dynamic>> getForecast(double lat, double lon) {
    return api.get(
      endPoint: '/forecast',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': apiKey,
        'units': 'metric',
      },
    );
  }
}
