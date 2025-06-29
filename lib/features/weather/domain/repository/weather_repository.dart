import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, List<WeatherDay>>> getFiveDayForecast(
    double lat,
    double lon,
  );
}
