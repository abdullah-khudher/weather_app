import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherRemoteDataSource])
void main() {
  late WeatherRepository weatherRepository;
  late WeatherRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepository = WeatherRepositoryImpl(mockRemoteDataSource);
  });

  group("getFiveDayForecast should call", () {
    test(
      "getFiveDayForecast should return List of WeatherDay without any Exeption",
      () async {
        // Arrange
        final lat = 37.7749;
        final lon = -122.4194;
        final List<ForecastItemModel> forecastList = [
          ForecastItemModel(
            dateTime: DateTime.now(),
            temperature: 20.0,
            weatherIcon: '01d',
            weatherMain: 'Clear',
            windSpeed: 5.0,
            humidity: 50,
            pressure: 1012,
          ),
          ForecastItemModel(
            dateTime: DateTime.now(),
            temperature: 20.0,
            weatherIcon: '01d',
            weatherMain: 'Clear',
            windSpeed: 5.0,
            humidity: 50,
            pressure: 1012,
          ),
        ];
        final WeatherForecastModel weatherForecastModel = WeatherForecastModel(
          forecasts: forecastList,
        );
        final expectedList = [
          WeatherDay(
            date: DateTime.now().toIso8601String().split('T')[0],
            condition: 'Clear',
            iconCode: '01d',
            minTemperature: 20.0,
            maxTemperature: 20.0,
            windSpeed: 5.0,
            humidity: 50,
            pressure: 1012,
            temperature: 20.0,
          ),
        ];

        when(
          mockRemoteDataSource.getForecast(lat, lon),
        ).thenAnswer((_) async => weatherForecastModel);

        // Act
        final result = await weatherRepository.getFiveDayForecast(lat, lon);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail("Expected success, got failure: $failure"),
          (weatherDays) {
            expect(weatherDays, isA<List<WeatherDay>>());
            expect(weatherDays, expectedList);
          },
        );
      },
    );

    test("getFiveDayForecast should throw Exception type Failure", () async {
      // Arrange
      final lat = 37.7749;
      final lon = -122.4194;

      when(mockRemoteDataSource.getForecast(lat, lon)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.connectionError,
          error: 'Connection error',
        ),
      );
      // Act
      final result = await weatherRepository.getFiveDayForecast(lat, lon);

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.errMessage, 'Connection error');
      }, (_) => fail("Expected failure, got success"));
    });

    test(
      "groupForecastsByDate should return Map<String, List<ForecastItemModel>> without any Exception",
      () {
        // Arrange
        final List<ForecastItemModel> forecastList = [
          ForecastItemModel(
            dateTime: DateTime.parse("2023-10-01T12:00:00Z"),
            temperature: 20.0,
            weatherIcon: '01d',
            weatherMain: 'Clear',
            windSpeed: 5.0,
            humidity: 50,
            pressure: 1012,
          ),
          ForecastItemModel(
            dateTime: DateTime.parse("2023-10-01T15:00:00Z"),
            temperature: 22.0,
            weatherIcon: '02d',
            weatherMain: 'Clouds',
            windSpeed: 6.0,
            humidity: 55,
            pressure: 1015,
          ),
        ];
        final expectedMap = {
          "2023-10-01": [
            ForecastItemModel(
              dateTime: DateTime.parse("2023-10-01T12:00:00Z"),
              temperature: 20.0,
              weatherIcon: '01d',
              weatherMain: 'Clear',
              windSpeed: 5.0,
              humidity: 50,
              pressure: 1012,
            ),
            ForecastItemModel(
              dateTime: DateTime.parse("2023-10-01T15:00:00Z"),
              temperature: 22.0,
              weatherIcon: '02d',
              weatherMain: 'Clouds',
              windSpeed: 6.0,
              humidity: 55,
              pressure: 1015,
            ),
          ],
        };
        // Act
        final result = WeatherRepositoryImpl(
          mockRemoteDataSource,
        ).groupForecastsByDate(forecastList);
        // Assert
        expect(result, isA<Map<String, List<ForecastItemModel>>>());
        expect(result, expectedMap);
      },
    );

    test(
      "buildWeatherDays should return list of WeatherDay without Exception",
      () {
        //arrange
        final Map<String, List<ForecastItemModel>> groupedByDate = {
          "2023-10-01": [
            ForecastItemModel(
              dateTime: DateTime.parse("2023-10-01T12:00:00Z"),
              temperature: 20.0,
              weatherIcon: '01d',
              weatherMain: 'Clear',
              windSpeed: 5.0,
              humidity: 50,
              pressure: 1012,
            ),
            ForecastItemModel(
              dateTime: DateTime.parse("2023-10-01T15:00:00Z"),
              temperature: 22.0,
              weatherIcon: '02d',
              weatherMain: 'Clouds',
              windSpeed: 6.0,
              humidity: 55,
              pressure: 1015,
            ),
          ],
        };
        final expectedList = [
          WeatherDay(
            date: "2023-10-01",
            condition: 'Clear',
            iconCode: '01d',
            minTemperature: 20.0,
            maxTemperature: 22.0,
            windSpeed: 5.0,
            humidity: 50,
            pressure: 1012,
            temperature: 20.0,
          ),
        ];
        // Act
        final result = WeatherRepositoryImpl(
          mockRemoteDataSource,
        ).buildWeatherDays(groupedByDate);
        // Assert
        expect(result, isA<List<WeatherDay>>());
        expect(result, expectedList);
      },
    );
  });
}
