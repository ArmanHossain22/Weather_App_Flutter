import 'package:flutter/material.dart';
import '../models/daily_forecast.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_code_helper.dart';

class DailyForecastSection extends StatelessWidget {
  final List<DailyForecast> forecasts;

  const DailyForecastSection({
    super.key,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    if (forecasts.isEmpty) {
      return const SizedBox.shrink();
    }

    // Show up to 10 days
    final displayForecasts = forecasts.length > 10
        ? forecasts.sublist(0, 10)
        : forecasts;

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
            '10-Day Forecast',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...displayForecasts.map((forecast) {
            final minTemp = forecast.minTemperature;
            final maxTemp = forecast.maxTemperature;
            // Calculate slider value (0.0 to 1.0) based on temperature range
            // For display purposes, we'll use a fixed value since slider is non-interactive
            final currentValue = 0.5;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      DateFormatter.formatDayOrToday(forecast.date),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Icon(
                    WeatherCodeHelper.getIcon(forecast.weatherCode),
                    color: WeatherCodeHelper.getColor(forecast.weatherCode),
                    size: 24,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 0,
                          ),
                        ),
                        child: Slider(
                          value: currentValue,
                          onChanged: null,
                          activeColor: Colors.orange,
                          inactiveColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      '${minTemp.round()}°  ${maxTemp.round()}°',
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

