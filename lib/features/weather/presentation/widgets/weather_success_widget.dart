import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/constants/location_constants.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_day_list_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_details_widget.dart';

class WeatherSeccessWidget extends StatelessWidget {
  final List<WeatherDay> days;
  final WeatherDay selectedDay;
  final int selectedIndex;
  final TemperatureUnit unit;

  const WeatherSeccessWidget({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.selectedIndex,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return RefreshIndicator(
      onRefresh: () =>
          context.read<WeatherCubit>().getFiveDayForecast(berlinLat, berlinLon),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: isLandscape
            ? Row(
                children: [
                  Expanded(
                    child: WeatherDetailsWidget(day: selectedDay, unit: unit),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 120.w,
                    child: WeatherDayListWidget(
                      isLandscape: true,
                      unit: unit,
                      days: days,
                      selectedIndex: selectedIndex,
                      onDaySelected: (index) {
                        context.read<WeatherCubit>().selectDay(index);
                      },
                    ),
                  ),
                ],
              )
            : ListView(
                children: [
                  SizedBox(height: 16.h),
                  WeatherDetailsWidget(day: selectedDay, unit: unit),
                  SizedBox(height: 100.h),
                  WeatherDayListWidget(
                    isLandscape: false,
                    unit: unit,
                    days: days,
                    selectedIndex: selectedIndex,
                    onDaySelected: (index) {
                      context.read<WeatherCubit>().selectDay(index);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
