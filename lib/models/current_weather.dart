class CurrentWeather {
  final double temperature;
  final int weatherCode;
  final double windSpeed;

  const CurrentWeather({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['temperature_2m'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
    );
  }
}

