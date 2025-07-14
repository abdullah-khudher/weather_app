import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherForecastModel> getForecast(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiService apiService;
  final String apiKey;

  WeatherRemoteDataSourceImpl({required this.apiService, required this.apiKey});

  @override
  Future<WeatherForecastModel> getForecast(double lat, double lon) async {
    final response = await apiService.get(
      endPoint: '/forecast',
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'appid': apiKey,
        'units': 'metric',
      },
    );
    if (response.statusCode != 200) throw Exception();
    return WeatherForecastModel.fromJson(response.data);
  }
}
