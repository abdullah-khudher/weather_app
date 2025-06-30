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
      child: isLandscape
          ? SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: WeatherDetailsWidget(day: selectedDay, unit: unit),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
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
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  WeatherDetailsWidget(day: selectedDay, unit: unit),
                  SizedBox(height: 80.h),
                  SizedBox(
                    height: 120.h,
                    child: WeatherDayListWidget(
                      isLandscape: false,
                      unit: unit,
                      days: days,
                      selectedIndex: selectedIndex,
                      onDaySelected: (index) {
                        context.read<WeatherCubit>().selectDay(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
