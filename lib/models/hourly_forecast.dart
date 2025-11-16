class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final double windSpeed;

  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson({
    required String time,
    required double temperature,
    required int weatherCode,
    required double windSpeed,
  }) {
    return HourlyForecast(
      time: DateTime.parse(time),
      temperature: temperature,
      weatherCode: weatherCode,
      windSpeed: windSpeed,
    );
  }
}

