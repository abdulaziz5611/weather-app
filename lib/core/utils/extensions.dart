import '../../features/settings/domain/entities/unit_preferences.dart';

extension NumX on num {
  String toTemp([TempUnit unit = TempUnit.celsius]) {
    if (unit == TempUnit.fahrenheit) {
      return '${(this * 9 / 5 + 32).round()}°';
    }
    return '${round()}°';
  }

  String toWindSpeed(WindUnit unit) {
    final value = switch (unit) {
      WindUnit.kmh => toDouble(),
      WindUnit.mph => toDouble() * 0.621371,
      WindUnit.ms => toDouble() / 3.6,
    };
    return value.round().toString();
  }

  String toPressure(PressureUnit unit) {
    if (unit == PressureUnit.inHg) {
      return (this * 0.02953).toStringAsFixed(2);
    }
    return round().toString();
  }
}

extension DateTimeX on DateTime {
  String toHourLabel() {
    final h = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour < 12 ? 'AM' : 'PM';
    return '$h $period';
  }
}
