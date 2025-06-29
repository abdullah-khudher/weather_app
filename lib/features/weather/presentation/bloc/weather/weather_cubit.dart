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
      (weatherDays) => emit(WeatherSuccess(weatherDays)),
    );
  }
}
