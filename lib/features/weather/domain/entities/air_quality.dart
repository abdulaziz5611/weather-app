import 'package:equatable/equatable.dart';

class AirQuality extends Equatable {
  final int aqi;
  final double pm25;
  final double pm10;
  final double ozone;
  final double nitrogenDioxide;

  const AirQuality({
    required this.aqi,
    required this.pm25,
    required this.pm10,
    required this.ozone,
    required this.nitrogenDioxide,
  });

  @override
  List<Object?> get props => [aqi, pm25, pm10, ozone, nitrogenDioxide];
}
