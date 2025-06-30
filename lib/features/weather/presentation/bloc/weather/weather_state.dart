import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';

enum TemperatureUnit { celsius, fahrenheit }

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final List<WeatherDay> forecast;
  final int selectedIndex;
  final TemperatureUnit unit;

  const WeatherSuccess({
    required this.forecast,
    this.selectedIndex = 0,
    required this.unit,
  });

  WeatherSuccess copyWith({
    List<WeatherDay>? forecast,
    int? selectedIndex,
    TemperatureUnit? unit,
  }) {
    return WeatherSuccess(
      forecast: forecast ?? this.forecast,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      unit: unit ?? this.unit,
    );
  }

  WeatherDay get selectedDay => forecast[selectedIndex];

  @override
  List<Object?> get props => [forecast, selectedIndex, unit];
}

class WeatherFailure extends WeatherState {
  final String failure;

  const WeatherFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
