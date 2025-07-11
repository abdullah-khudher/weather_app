import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theming/styles.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

class TemperatureToggleButton extends StatelessWidget {
  const TemperatureToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          final isCelsius = state.unit == TemperatureUnit.celsius;
          return ElevatedButton(
            child: Text(
              isCelsius ? 'Change to °F' : 'Change to °C',
              style: TextStyles.font16BlackNormal,
            ),
            onPressed: () {
              context.read<WeatherCubit>().toggleTemperatureUnit();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
