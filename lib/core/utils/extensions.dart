extension NumX on num {
  String toTemp() => '${round()}°';
}

extension DateTimeX on DateTime {
  String toHourLabel() {
    final h = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour < 12 ? 'AM' : 'PM';
    return '$h $period';
  }
}
