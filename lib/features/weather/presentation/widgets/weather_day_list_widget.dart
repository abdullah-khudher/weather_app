import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_day_item_widget.dart';

class WeatherDayListWidget extends StatelessWidget {
  final List<WeatherDay> days;
  final int selectedIndex;

  const WeatherDayListWidget({
    super.key,
    required this.days,
    required this.selectedIndex,
    required Null Function(dynamic index) onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return WeatherDayItemWidget(
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
