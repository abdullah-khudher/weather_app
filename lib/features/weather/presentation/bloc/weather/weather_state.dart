import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';

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

  const WeatherSuccess(this.forecast, {this.selectedIndex = 0});

  WeatherDay get selectedDay => forecast[selectedIndex];

  @override
  List<Object?> get props => [forecast, selectedIndex];
}

class WeatherFailure extends WeatherState {
  final String failure;

  const WeatherFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
