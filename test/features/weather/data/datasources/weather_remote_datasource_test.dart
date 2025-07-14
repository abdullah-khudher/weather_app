import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/services/api_service.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_model.dart';

import 'weather_remote_datasource_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late WeatherRemoteDataSource weatherRemoteDataSource;
  late ApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    weatherRemoteDataSource = WeatherRemoteDataSourceImpl(
      apiKey: "apiKey",
      apiService: mockApiService,
    );
  });

  group("call getForecast function", () {
    test(
      'call getForecast function and get WeatherForecastModel with statusCode == 200',
      () async {
        // arrange
        final double lat = 37.7749;
        final double lon = -122.4194;
        final Map<String, dynamic> queryParameters = {
          'lat': lat,
          'lon': lon,
          'appid': "apiKey",
          'units': 'metric',
        };
        final ForecastItemModel forecastItemModel = ForecastItemModel(
          dateTime: DateTime.now(),
          temperature: 20.0,
          weatherIcon: '01d',
          weatherMain: 'Clear',
          windSpeed: 5.0,
          humidity: 50,
          pressure: 1012,
        );

        final WeatherForecastModel responseModel = WeatherForecastModel(
          forecasts: [forecastItemModel, forecastItemModel],
        );

        when(
          mockApiService.get(
            endPoint: '/forecast',
            queryParameters: queryParameters,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseModel.toJson(),
            statusCode: 200,
            requestOptions: RequestOptions(path: '/forecast'),
          ),
        );

        // act

        final result = await weatherRemoteDataSource.getForecast(lat, lon);

        // assert
        expect(result, responseModel);
      },
    );

    test(
      "call getForecast function and throw Exception with statusCode != 200",
      () async {
        // arrange
        final double lat = 37.7749;
        final double lon = -122.4194;
        final Map<String, dynamic> queryParameters = {
          'lat': lat,
          'lon': lon,
          'appid': "apiKey",
          'units': 'metric',
        };

        final expextedException = throwsA(isA<Exception>());

        when(
          mockApiService.get(
            endPoint: '/forecast',
            queryParameters: queryParameters,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: null,
            statusCode: 404,
            requestOptions: RequestOptions(path: '/forecast'),
          ),
        );

        // act
        result() async => await weatherRemoteDataSource.getForecast(lat, lon);

        // assert
        expect(result, expextedException);
      },
    );
  });
}
