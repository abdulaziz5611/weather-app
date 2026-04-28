import '../theme/app_gradients.dart';

class TimeOfDayHelper {
  TimeOfDayHelper._();

  static TimeOfDayPeriod fromHour(int hour) {
    if (hour >= 5 && hour < 12) return TimeOfDayPeriod.morning;
    if (hour >= 12 && hour < 17) return TimeOfDayPeriod.afternoon;
    if (hour >= 17 && hour < 21) return TimeOfDayPeriod.evening;
    return TimeOfDayPeriod.night;
  }

  static TimeOfDayPeriod current() => fromHour(DateTime.now().hour);
}
