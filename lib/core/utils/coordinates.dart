import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  final double latitude;
  final double longitude;

  const Coordinates({required this.latitude, required this.longitude});

  static const porto = Coordinates(latitude: 41.1579, longitude: -8.6291);

  @override
  List<Object?> get props => [latitude, longitude];
}
