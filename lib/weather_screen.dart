import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/services/geocoding_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/daily_forecast_section.dart';
import 'package:weather_app/widgets/hourly_forecast_section.dart';
import 'package:weather_app/widgets/location_header.dart';
import 'package:weather_app/widgets/search_field.dart';
import 'package:weather_app/widgets/temperature_display.dart';
import 'package:weather_app/widgets/weather_description_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _searchController = TextEditingController(text: 'Dhaka');
  final _geocodingService = GeocodingService();
  final _weatherService = WeatherService();

  bool _loading = false;
  String? _error;
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherInformation('Dhaka');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeatherInformation(String city) async {
    if (city.trim().isEmpty) {
      setState(() {
        _error = 'Please enter a city name';
        _loading = false;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final location = await _geocodingService.searchLocation(city);

      final weatherData = await _weatherService.getWeatherForecast(location);

      setState(() {
        _weatherData = weatherData;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
        _loading = false;
        _weatherData = null;
      });
    }
  }

  void _handleSearch() {
    final cityName = _searchController.text.trim();
    if (cityName.isNotEmpty) {
      _fetchWeatherInformation(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: _loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : _error != null
                  ? _buildErrorView()
                  : _weatherData == null
                      ? _buildEmptyView()
                      : _buildWeatherView(),
        ),
      ),
    );
  }

  Widget _buildWeatherView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            controller: _searchController,
            onSearch: _handleSearch,
          ),
          const SizedBox(height: 20),
          LocationHeader(
            locationName: _weatherData!.location.name,
            countryName: _weatherData!.location.country,
          ),
          const SizedBox(height: 30),
          TemperatureDisplay(
            temperature: _weatherData!.current.temperature,
            weatherCode: _weatherData!.current.weatherCode,
          ),
          const SizedBox(height: 20),
          WeatherDescriptionCard(
            weatherCode: _weatherData!.current.weatherCode,
            windSpeed: _weatherData!.current.windSpeed,
          ),
          const SizedBox(height: 20),
          HourlyForecastSection(
            forecasts: _weatherData!.hourlyForecasts,
          ),
          const SizedBox(height: 20),
          DailyForecastSection(
            forecasts: _weatherData!.dailyForecasts,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'An unknown error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            SearchField(
              controller: _searchController,
              onSearch: _handleSearch,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Search for Weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter a city name to get weather information',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            SearchField(
              controller: _searchController,
              onSearch: _handleSearch,
            ),
          ],
        ),
      ),
    );
  }
}
