enum TempUnit { celsius, fahrenheit }

enum WindUnit { kmh, mph, ms }

enum PressureUnit { hpa, inHg }

enum DistanceUnit { km, mi }

enum AppThemeMode { light, dark, auto }

extension TempUnitX on TempUnit {
  String get label => this == TempUnit.celsius ? 'C' : 'F';
  String get symbol => this == TempUnit.celsius ? '°C' : '°F';
}

extension WindUnitX on WindUnit {
  String get label {
    switch (this) {
      case WindUnit.kmh:
        return 'km/h';
      case WindUnit.mph:
        return 'mph';
      case WindUnit.ms:
        return 'm/s';
    }
  }
}

extension PressureUnitX on PressureUnit {
  String get label =>
      this == PressureUnit.hpa ? 'hPa' : 'inHg';
}

extension DistanceUnitX on DistanceUnit {
  String get label => this == DistanceUnit.km ? 'km' : 'mi';
}
