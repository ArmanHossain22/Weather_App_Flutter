import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/daily_forecast.dart';
import 'package:weather_app/models/hourly_forecast.dart';
import 'package:weather_app/models/location.dart';

class WeatherData {
  final Location location;
  final CurrentWeather current;
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;

  const WeatherData({
    required this.location,
    required this.current,
    required this.hourlyForecasts,
    required this.dailyForecasts,
  });

  factory WeatherData.fromJson({
    required Map<String, dynamic> json,
    required Location location,
  }) {
    final current = json['current'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;

    // Parse current weather
    final currentWeather = CurrentWeather.fromJson(current);

    // Parse hourly forecasts
    final hourlyTimes = (hourly['time'] as List).cast<String>();
    final hourlyTemps = (hourly['temperature_2m'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    final hourlyCodes = (hourly['weather_code'] as List).cast<int>();
    final hourlyWinds = (hourly['wind_speed_10m'] as List)
        .map((e) => (e as num).toDouble())
        .toList();

    // Ensure all arrays have the same length, limit to 24 hours
    final hourlyMinLength = [
      hourlyTimes.length,
      hourlyTemps.length,
      hourlyCodes.length,
      hourlyWinds.length,
      24, // Limit to 24 hours
    ].reduce((a, b) => a < b ? a : b);

    final hourlyForecasts = <HourlyForecast>[];
    for (int i = 0; i < hourlyMinLength; i++) {
      hourlyForecasts.add(
        HourlyForecast.fromJson(
          time: hourlyTimes[i],
          temperature: hourlyTemps[i],
          weatherCode: hourlyCodes[i],
          windSpeed: hourlyWinds[i],
        ),
      );
    }

    // Parse daily forecasts
    final dailyTimes = (daily['time'] as List).cast<String>();
    final dailyMaxTemps = (daily['temperature_2m_max'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    final dailyMinTemps = (daily['temperature_2m_min'] as List)
        .map((e) => (e as num).toDouble())
        .toList();
    final dailySunrises = (daily['sunrise'] as List).cast<String>();
    final dailySunsets = (daily['sunset'] as List).cast<String>();
    final dailyCodes = (daily['weather_code'] as List).cast<int>();

    // Ensure all arrays have the same length
    final minLength = [
      dailyTimes.length,
      dailyMaxTemps.length,
      dailyMinTemps.length,
      dailySunrises.length,
      dailySunsets.length,
      dailyCodes.length,
    ].reduce((a, b) => a < b ? a : b);

    final dailyForecasts = <DailyForecast>[];
    for (int i = 0; i < minLength; i++) {
      dailyForecasts.add(
        DailyForecast.fromJson(
          date: dailyTimes[i],
          maxTemp: dailyMaxTemps[i],
          minTemp: dailyMinTemps[i],
          sunrise: dailySunrises[i],
          sunset: dailySunsets[i],
          weatherCode: dailyCodes[i],
        ),
      );
    }

    return WeatherData(
      location: location,
      current: currentWeather,
      hourlyForecasts: hourlyForecasts,
      dailyForecasts: dailyForecasts,
    );
  }
}

