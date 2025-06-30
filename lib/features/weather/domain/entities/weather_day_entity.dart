import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

class WeatherDay extends Equatable {
  final String date;
  final String condition;
  final String iconCode;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double humidity;
  final double pressure;
  final double windSpeed;

  const WeatherDay({
    required this.date,
    required this.condition,
    required this.iconCode,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
    date,
    condition,
    iconCode,
    temperature,
    minTemperature,
    maxTemperature,
    humidity,
    pressure,
    windSpeed,
  ];
}

extension WeatherDayExtensions on WeatherDay {
  String displayTemp(double value, TemperatureUnit unit) {
    final temp = unit == TemperatureUnit.celsius ? value : (value * 9 / 5) + 32;
    return temp.toStringAsFixed(0);
  }

  String getTemperature(TemperatureUnit unit) => displayTemp(temperature, unit);
  String getMinTemperature(TemperatureUnit unit) =>
      displayTemp(minTemperature, unit);
  String getMaxTemperature(TemperatureUnit unit) =>
      displayTemp(maxTemperature, unit);
}
