import 'package:flutter/material.dart';
import '../utils/weather_code_helper.dart';

class WeatherDescriptionCard extends StatelessWidget {
  final int weatherCode;
  final double windSpeed;

  const WeatherDescriptionCard({
    super.key,
    required this.weatherCode,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${WeatherCodeHelper.getDescription(weatherCode)}. Wind up to ${windSpeed.round()} km/h.',
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
    );
  }
}

