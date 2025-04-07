// Function to calculate distance between two points using Haversine formula
import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371;
  final dLat = degreesToRadians(lat2 - lat1);
  final dLon = degreesToRadians(lon2 - lon1);
  final a = pow(sin(dLat / 2), 2) +
      cos(degreesToRadians(lat1)) *
          cos(degreesToRadians(lat2)) *
          pow(sin(dLon / 2), 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

bool withinRadius({
  required double userLatitude,
  required double userLongitude,
  required double locLatitude,
  required double locLongitude,
  required double radiusMeter,
}) {
  final distance = calculateDistance(
        userLatitude,
        userLongitude,
        locLatitude,
        locLongitude,
      ) *
      1000;
  return distance <= radiusMeter;
}
