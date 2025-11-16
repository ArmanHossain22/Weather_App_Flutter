class Location {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  const Location({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  String get fullName => '$name, $country';

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

