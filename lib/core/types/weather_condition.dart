enum WeatherCondition {
  clear,
  partlyCloudy,
  cloudy,
  rain,
  snow,
  thunder,
  fog,
  moon,
  moonCloud,
}

class WeatherConditionMapper {
  WeatherConditionMapper._();

  static WeatherCondition fromWmoCode(int code, {bool isDay = true}) {
    if (code == 0) {
      return isDay ? WeatherCondition.clear : WeatherCondition.moon;
    }
    if (code >= 1 && code <= 2) {
      return isDay ? WeatherCondition.partlyCloudy : WeatherCondition.moonCloud;
    }
    if (code == 3) return WeatherCondition.cloudy;
    if (code >= 45 && code <= 48) return WeatherCondition.fog;
    if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
      return WeatherCondition.rain;
    }
    if ((code >= 71 && code <= 77) || (code >= 85 && code <= 86)) {
      return WeatherCondition.snow;
    }
    if (code >= 95 && code <= 99) return WeatherCondition.thunder;
    return WeatherCondition.cloudy;
  }

  static String label(WeatherCondition c) {
    switch (c) {
      case WeatherCondition.clear:
        return 'Clear';
      case WeatherCondition.partlyCloudy:
        return 'Partly Cloudy';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rain:
        return 'Rain';
      case WeatherCondition.snow:
        return 'Snow';
      case WeatherCondition.thunder:
        return 'Thunderstorms';
      case WeatherCondition.fog:
        return 'Fog';
      case WeatherCondition.moon:
        return 'Clear';
      case WeatherCondition.moonCloud:
        return 'Partly Cloudy';
    }
  }
}
