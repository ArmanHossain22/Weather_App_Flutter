import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../models/weather_data.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.open-meteo.com/v1';

  Future<WeatherData> getWeatherForecast(Location location) async {
    final uri = Uri.parse(
      '$_baseUrl/forecast?'
      'latitude=${location.latitude}&'
      'longitude=${location.longitude}&'
      'daily=temperature_2m_max,temperature_2m_min,sunrise,sunset,weather_code&'
      'hourly=temperature_2m,weather_code,wind_speed_10m&'
      'current=temperature_2m,weather_code,wind_speed_10m&'
      'timezone=auto',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Weather API failed with status code: ${response.statusCode}');
      }

      final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherData.fromJson(
        json: decodedData,
        location: location,
      );
    } on http.ClientException {
      throw Exception('Network error: Unable to connect to weather service');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Unexpected error: $e');
    }
  }
}

