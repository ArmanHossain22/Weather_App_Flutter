import 'package:flutter/material.dart';
import '../utils/weather_code_helper.dart';

class TemperatureDisplay extends StatelessWidget {
  final double temperature;
  final int weatherCode;

  const TemperatureDisplay({
    super.key,
    required this.temperature,
    required this.weatherCode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Text(
            '${temperature.round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            WeatherCodeHelper.getShortDescription(weatherCode),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

