import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final String locationName;
  final String countryName;

  const LocationHeader({
    super.key,
    required this.locationName,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'MY LOCATION',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$locationName, $countryName',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

