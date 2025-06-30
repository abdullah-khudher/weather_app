import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/theming/styles.dart';
import 'package:weather_app/core/utils/date_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/temperature_toggle_button.dart';

import 'weather_icon_widget.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDay day;
  final TemperatureUnit unit;
  final bool isLandscape;

  const WeatherDetailsWidget({
    super.key,
    required this.day,
    required this.unit,
    this.isLandscape = false,
  });

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day.condition, style: TextStyles.font20BlackW500),
            const TemperatureToggleButton(),
          ],
        ),
        isLandscape
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: WeatherIconWidget(
                          iconCode: day.iconCode,
                          height: 250.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${day.getTemperature(unit)}°',
                        style: TextStyles.font56BlackBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  WeatherIconWidget(
                    iconCode: day.iconCode,
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    '${day.getTemperature(unit)}°',
                    style: TextStyles.font56BlackBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
        SizedBox(height: 8.h),
        Text(
          'Humidity: ${day.humidity.toStringAsFixed(0)}%',
          style: TextStyles.font20BlackW500,
        ),
        SizedBox(height: 8.h),
        Text(
          'Pressure: ${day.pressure.toStringAsFixed(0)} hPa',
          style: TextStyles.font20BlackW500,
        ),
        SizedBox(height: 8.h),
        Text(
          'Wind: ${day.windSpeed.toStringAsFixed(1)} km/h',
          style: TextStyles.font20BlackW500,
        ),
      ],
    );
  }
}
