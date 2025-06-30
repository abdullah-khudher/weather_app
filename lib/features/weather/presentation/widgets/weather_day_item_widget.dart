import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/theming/colors.dart';
import 'package:weather_app/core/theming/styles.dart';
import 'package:weather_app/core/utils/date_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

import 'weather_icon_widget.dart';

class WeatherDayItemWidget extends StatelessWidget {
  final WeatherDay day;
  final bool isSelected;
  final VoidCallback onTap;
  final TemperatureUnit unit;
  final bool isLandscape;

  const WeatherDayItemWidget({
    super.key,
    required this.unit,
    this.isLandscape = false,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        // height: 300.h,
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.mainBlue : ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppDateUtils.getWeekdayShort(day.date),
              style: TextStyles.font16BlackNormal,
            ),
            WeatherIconWidget(
              iconCode: day.iconCode,
              height: isLandscape ? 100.h : 50.h,
              width: 40.w,
              fit: BoxFit.cover,
            ),
            Text(
              '${day.getMinTemperature(unit)}/${day.getMaxTemperature(unit)}°',
              style: TextStyles.font16BlackNormal,
            ),
          ],
        ),
      ),
    );
  }
}
