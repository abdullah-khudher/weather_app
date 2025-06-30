import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/theming/colors.dart';
import 'package:weather_app/core/theming/styles.dart';
import 'package:weather_app/core/utils/date_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';

import 'weather_icon_widget.dart';

class WeatherDayItemWidget extends StatelessWidget {
  final WeatherDay day;
  final bool isSelected;
  final VoidCallback onTap;

  const WeatherDayItemWidget({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
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
              height: 40.h,
              width: 40.w,
            ),
            Text(
              '${day.minTemperature.toInt()}/${day.maxTemperature.toInt()}°',
              style: TextStyles.font16BlackNormal,
            ),
          ],
        ),
      ),
    );
  }
}
