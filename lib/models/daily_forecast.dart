class DailyForecast {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final DateTime sunrise;
  final DateTime sunset;
  final int weatherCode;

  const DailyForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    required this.sunrise,
    required this.sunset,
    required this.weatherCode,
  });

  factory DailyForecast.fromJson({
    required String date,
    required double maxTemp,
    required double minTemp,
    required String sunrise,
    required String sunset,
    required int weatherCode,
  }) {
    return DailyForecast(
      date: DateTime.parse(date),
      maxTemperature: maxTemp,
      minTemperature: minTemp,
      sunrise: DateTime.parse(sunrise),
      sunset: DateTime.parse(sunset),
      weatherCode: weatherCode,
    );
  }
}

