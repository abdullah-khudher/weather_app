import 'package:bloc/bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

import '../../../domain/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;

  WeatherCubit(this.repository) : super(WeatherInitial());

  Future<void> getFiveDayForecast(double lat, double lon) async {
    emit(WeatherLoading());

    final result = await repository.getFiveDayForecast(lat, lon);

    result.fold(
      (failure) => emit(WeatherFailure(failure.errMessage)),
      (weatherDays) => emit(
        WeatherSuccess(forecast: weatherDays, unit: TemperatureUnit.celsius),
      ),
    );
  }

  void selectDay(int index) {
    final currentState = state;
    if (currentState is WeatherSuccess) {
      emit(
        WeatherSuccess(
          selectedIndex: index,
          forecast: currentState.forecast,
          unit: currentState.unit,
        ),
      );
    }
  }

  void toggleTemperatureUnit() {
    if (state is WeatherSuccess) {
      final success = state as WeatherSuccess;
      final newUnit = success.unit == TemperatureUnit.celsius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celsius;
      emit(success.copyWith(unit: newUnit));
    }
  }
}
