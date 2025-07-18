import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/models/weather_forecast_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<WeatherDay>>> getFiveDayForecast(
    double lat,
    double lon,
  ) async {
    try {
      final rawData = await remoteDataSource.getForecast(lat, lon);
      final forecastList = rawData.forecasts;
      final groupedByDate = groupForecastsByDate(forecastList);
      final result = buildWeatherDays(groupedByDate);

      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Map<String, List<ForecastItemModel>> groupForecastsByDate(
    List<ForecastItemModel> forecasts,
  ) {
    final map = <String, List<ForecastItemModel>>{};
    for (final item in forecasts) {
      final date = item.dateTime.toIso8601String().split('T')[0];
      map.putIfAbsent(date, () => []).add(item);
    }
    return map;
  }

  List<WeatherDay> buildWeatherDays(
    Map<String, List<ForecastItemModel>> groupedByDate,
  ) {
    final List<WeatherDay> list = groupedByDate.entries.map((entry) {
      final date = entry.key;
      final items = entry.value;

      final temps = items.map((e) => e.temperature).toList();
      final minTemp = temps.reduce(min).toDouble();
      final maxTemp = temps.reduce(max).toDouble();

      final middayItem = items.firstWhere(
        (e) => e.dateTime.hour == 12,
        orElse: () => items[0],
      );

      return WeatherDay(
        date: date,
        condition: middayItem.weatherMain,
        iconCode: middayItem.weatherIcon,
        temperature: middayItem.temperature,
        humidity: middayItem.humidity.toDouble(),
        pressure: middayItem.pressure.toDouble(),
        windSpeed: middayItem.windSpeed,
        minTemperature: minTemp,
        maxTemperature: maxTemp,
      );
    }).toList();

    return list;
  }
}
