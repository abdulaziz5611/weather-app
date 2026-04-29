import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeocodedLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String name;
  final String country;
  final String? admin1;

  const GeocodedLocation({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.country,
    this.admin1,
  });

  @override
  List<Object?> get props => [latitude, longitude, name, country, admin1];
}

abstract class LocationService {
  Future<bool> requestPermission();
  Future<GeocodedLocation?> getCurrentLocation();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<bool> requestPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<GeocodedLocation?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
      var name = 'My Location';
      var country = '';
      String? admin1;
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          name = p.locality ??
              p.subAdministrativeArea ??
              p.administrativeArea ??
              'My Location';
          country = p.country ?? '';
          admin1 = p.administrativeArea;
        }
      } catch (_) {}
      return GeocodedLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        name: name,
        country: country,
        admin1: admin1,
      );
    } catch (_) {
      return null;
    }
  }
}
