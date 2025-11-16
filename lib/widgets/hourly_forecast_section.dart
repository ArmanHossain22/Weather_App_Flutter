import 'package:flutter/material.dart';
import '../models/hourly_forecast.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_code_helper.dart';

class HourlyForecastSection extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const HourlyForecastSection({
    super.key,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    if (forecasts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Now • Hourly',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: forecasts.length > 12 ? 12 : forecasts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) {
                final forecast = forecasts[index];
                return Column(
                  children: [
                    Text(
                      DateFormatter.formatTime(forecast.time),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      WeatherCodeHelper.getIcon(forecast.weatherCode),
                      color: WeatherCodeHelper.getColor(forecast.weatherCode),
                      size: 26,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${forecast.temperature.round()}°',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

