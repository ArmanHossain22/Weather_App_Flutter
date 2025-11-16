import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart';

class GeocodingService {
  static const String _baseUrl = 'https://geocoding-api.open-meteo.com/v1';

  Future<Location> searchLocation(String cityName) async {
    if (cityName.trim().isEmpty) {
      throw Exception('City name cannot be empty');
    }

    final uri = Uri.parse(
      '$_baseUrl/search?name=${Uri.encodeComponent(cityName)}&count=1&language=en&format=json',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Geocoding failed with status code: ${response.statusCode}');
      }

      final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
      final results = decodedData['results'] as List<dynamic>?;

      if (results == null || results.isEmpty) {
        throw Exception('No city found with name: $cityName');
      }

      final firstResult = results[0] as Map<String, dynamic>;
      return Location.fromJson(firstResult);
    } on http.ClientException {
      throw Exception('Network error: Unable to connect to geocoding service');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Unexpected error: $e');
    }
  }
}

