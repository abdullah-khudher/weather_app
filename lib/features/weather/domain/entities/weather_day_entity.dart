import 'package:equatable/equatable.dart';

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
