import 'dart:math';

class GeoUtils {
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    // Convert degrees to radians
    final double lat1Rad = _degreesToRadians(lat1);
    final double lon1Rad = _degreesToRadians(lon1);
    final double lat2Rad = _degreesToRadians(lat2);
    final double lon2Rad = _degreesToRadians(lon2);

    // Haversine formula
    final double dLat = lat2Rad - lat1Rad;
    final double dLon = lon2Rad - lon1Rad;

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final double distance = earthRadius * c;

    return distance; // Distance in kilometers
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}

void main() {
  double lat1 = 3.0;
  double lon1 = 4.0;
  double lat2 = 5.0;
  double lon2 = 6.0;

  double distance = GeoUtils.calculateDistance(lat1, lon1, lat2, lon2);

  print("Distance: $distance km");
}
