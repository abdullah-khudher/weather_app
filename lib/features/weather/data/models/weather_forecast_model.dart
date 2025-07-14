import 'package:equatable/equatable.dart';

class WeatherForecastModel extends Equatable {
  final List<ForecastItemModel> forecasts;

  const WeatherForecastModel({required this.forecasts});

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      forecasts: (json['list'] as List)
          .map((item) => ForecastItemModel.fromJson(item))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {'list': forecasts.map((item) => item.toJson()).toList()};
  }

  @override
  List<Object?> get props => [forecasts];
}

class ForecastItemModel extends Equatable {
  final DateTime dateTime;
  final String weatherMain;
  final String weatherIcon;
  final double temperature;
  final int humidity;
  final int pressure;
  final double windSpeed;

  const ForecastItemModel({
    required this.dateTime,
    required this.weatherMain,
    required this.weatherIcon,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  factory ForecastItemModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return ForecastItemModel(
      dateTime: DateTime.parse(json['dt_txt']),
      weatherMain: weather['main'],
      weatherIcon: weather['icon'],
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dt_txt': dateTime.toIso8601String(),
      'weather': [
        {'main': weatherMain, 'icon': weatherIcon},
      ],
      'main': {'temp': temperature, 'humidity': humidity, 'pressure': pressure},
      'wind': {'speed': windSpeed},
    };
  }

  @override
  List<Object?> get props => [
    dateTime,
    weatherMain,
    weatherIcon,
    temperature,
    humidity,
    pressure,
    windSpeed,
  ];
}
