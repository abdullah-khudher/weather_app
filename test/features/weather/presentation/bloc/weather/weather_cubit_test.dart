import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

import 'weather_cubit_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late WeatherCubit weatherCubit;
  late WeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    weatherCubit = WeatherCubit(mockWeatherRepository);
  });

  group("getFiveDayForecast call and emit states", () {
    test(
      'getFiveDayForecast should emit WeatherLoading state and WeatherSuccess state with list of weatherDays when calling getFiveDayForecast',
      () {
        // arrange
        final lat = 37.7749;
        final lon = -122.4194;
        final List<WeatherDay> weatherDays = [
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
          mockWeatherRepository.getFiveDayForecast(lat, lon),
        ).thenAnswer((_) async => Future.value(Right(weatherDays)));

        // assert
        expectLater(
          weatherCubit.stream,
          emitsInOrder([
            WeatherLoading(),
            WeatherSuccess(
              forecast: weatherDays,
              unit: TemperatureUnit.celsius,
            ),
          ]),
        );

        // act
        weatherCubit.getFiveDayForecast(lat, lon);
      },
    );

    test(
      'getFiveDayForecast should emit WeatherLoading state and WeatherFailure state with failure.errMessage when calling getFiveDayForecast',
      () {
        // arrange
        final lat = 37.7749;
        final lon = -122.4194;
        final failureMessage = 'Failed to fetch weather data';
        when(mockWeatherRepository.getFiveDayForecast(lat, lon)).thenAnswer(
          (_) async => Future.value(Left(ServerFailure(failureMessage))),
        );
        // assert
        expectLater(
          weatherCubit.stream,
          emitsInOrder([WeatherLoading(), WeatherFailure(failureMessage)]),
        );
        // act
        weatherCubit.getFiveDayForecast(lat, lon);
      },
    );
  });
  test(
    "selectDay should emit WeatherSuccess state with changeing selectedIndex with new vlaue from the paramter",
    () {
      // arrange
      final weatherDays = [
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
      final initialState = WeatherSuccess(
        forecast: weatherDays,
        unit: TemperatureUnit.celsius,
      );

      weatherCubit.emit(initialState);

      // assert
      expectLater(
        weatherCubit.stream,
        emitsInOrder([
          WeatherSuccess(
            selectedIndex: 1,
            forecast: weatherDays,
            unit: TemperatureUnit.celsius,
          ),
        ]),
      );
      // act
      weatherCubit.selectDay(1);
    },
  );

  test(
    "toggleTemperatureUnit should emit WeatherSuccess state with changeing TemperatureUnit value",
    () {
      // arrange
      final weatherDays = [
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
      final initialState = WeatherSuccess(
        forecast: weatherDays,
        unit: TemperatureUnit.celsius,
      );
      weatherCubit.emit(initialState);
      // assert
      expectLater(
        weatherCubit.stream,
        emitsInOrder([
          WeatherSuccess(
            unit: TemperatureUnit.fahrenheit,
            forecast: weatherDays,
          ),
        ]),
      );
      // act
      weatherCubit.toggleTemperatureUnit();
    },
  );
}
