import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_error_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_success_widget.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherFailure) {
              return const WeatherErrorWidget();
            }
            if (state is WeatherSuccess) {
              final List<WeatherDay> days = state.forecast;
              final WeatherDay selectedDay = days[state.selectedIndex];

              return WeatherSeccessWidget(
                days: days,
                selectedDay: selectedDay,
                selectedIndex: state.selectedIndex,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
