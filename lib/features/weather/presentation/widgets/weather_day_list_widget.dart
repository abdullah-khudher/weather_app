import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_day_item_widget.dart';

class WeatherDayListWidget extends StatelessWidget {
  final List<WeatherDay> days;
  final int selectedIndex;
  final bool isLandscape;
  final TemperatureUnit unit;

  const WeatherDayListWidget({
    super.key,
    required this.isLandscape,
    required this.unit,
    required this.days,
    required this.selectedIndex,
    required Null Function(dynamic index) onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLandscape ? null : 120.h,
      width: isLandscape ? 100.w : null,
      child: ListView.builder(
        scrollDirection: isLandscape ? Axis.vertical : Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return WeatherDayItemWidget(
            unit: unit,
            day: day,
            isSelected: index == selectedIndex,
            onTap: () {
              context.read<WeatherCubit>().selectDay(index);
            },
          );
        },
      ),
    );
  }
}
