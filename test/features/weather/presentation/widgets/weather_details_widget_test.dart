import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/utils/date_utils.dart';
import 'package:weather_app/features/weather/domain/entities/weather_day_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_details_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_icon_widget.dart';

import 'weather_details_widget_test.mocks.dart';

@GenerateMocks([WeatherCubit])
void main() {
  late WeatherCubit mockWeatherCubit;
  setUp(() {
    mockWeatherCubit = MockWeatherCubit();
  });
  testWidgets(
    'displays correct dayName, condition, WeatherIconWidget, temperature, humidity, pressure, windSpeed',
    (tester) async {
      // Arrange
      final date = '2023-10-01'; // Example date
      final String dayName = AppDateUtils.getWeekdayName(date);
      final WeatherDay weatherDay = WeatherDay(
        date: date,
        condition: 'Sunny',
        iconCode: '01d',
        temperature: 25.0,
        minTemperature: 20.0,
        maxTemperature: 30.0,
        humidity: 60,
        pressure: 1012,
        windSpeed: 5.0,
      );

      final initialState = WeatherSuccess(
        forecast: [weatherDay],
        unit: TemperatureUnit.celsius,
      );
      // Stub state and stream

      when(mockWeatherCubit.state).thenReturn(initialState);
      when(
        mockWeatherCubit.stream,
      ).thenAnswer((_) => Stream.value(initialState));

      await tester.pumpWidget(
        MaterialApp(
          home: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (_, __) => BlocProvider<WeatherCubit>.value(
              value: mockWeatherCubit,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: WeatherDetailsWidget(
                    day: weatherDay,
                    unit: TemperatureUnit.celsius,
                    isLandscape: false,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      // Act
      await tester.pump();

      // Assert
      expect(find.text(dayName), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.byType(WeatherIconWidget), findsOneWidget);
      expect(
        find.text('${weatherDay.getTemperature(TemperatureUnit.celsius)}°'),
        findsOneWidget,
      );
      expect(find.text('Humidity: 60%'), findsOneWidget);
      expect(find.text('Pressure: 1012 hPa'), findsOneWidget);
      expect(find.text('Wind: 5.0 km/h'), findsOneWidget);
    },
  );
}
