import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';

class WeatherErrorWidget extends StatelessWidget {
  const WeatherErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Something went wrong.'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<WeatherCubit>().getFiveDayForecast(48.8566, 2.3522);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
