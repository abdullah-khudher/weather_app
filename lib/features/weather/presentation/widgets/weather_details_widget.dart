import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/theming/colors.dart';
import 'package:weather_app/core/theming/styles.dart';
import 'package:weather_app/core/utils/date_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';

import 'weather_icon_widget.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDay day;

  const WeatherDetailsWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppDateUtils.getWeekdayName(day.date),
          style: TextStyles.font24BlackBold,
          textAlign: TextAlign.center,
        ),
        Text(day.condition, style: TextStyles.font20BlackW500),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            color: ColorsManager.mainBlue,
            child: WeatherIconWidget(
              iconCode: day.iconCode,
              height: 200.h,
              width: double.infinity,
            ),
          ),
        ),
        Text(
          '${day.temperature.toStringAsFixed(0)}°',
          style: TextStyles.font56BlackBold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          'Humidity: ${day.humidity.toStringAsFixed(0)}%',
          style: TextStyles.font20BlackW500,
        ),
        SizedBox(height: 16.h),
        Text(
          'Pressure: ${day.pressure.toStringAsFixed(0)} hPa',
          style: TextStyles.font20BlackW500,
        ),
        SizedBox(height: 16.h),
        Text(
          'Wind: ${day.windSpeed.toStringAsFixed(1)} km/h',
          style: TextStyles.font20BlackW500,
        ),
      ],
    );
  }
}
