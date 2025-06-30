import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconCode;
  final double height;
  final double? width;
  final BoxFit fit;

  const WeatherIconWidget({
    required this.iconCode,
    required this.height,
    this.width,
    this.fit = BoxFit.contain,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'http://openweathermap.org/img/wn/$iconCode@4x.png',
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) =>
          Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, size: height * 0.5),
    );
  }
}
