import '../../../../core/types/weather_condition.dart';
import '../../domain/entities/weather_forecast.dart';
import 'current_weather_model.dart';
import 'daily_forecast_model.dart';
import 'hourly_forecast_model.dart';

class WeatherForecastModel extends WeatherForecast {
  const WeatherForecastModel({
    required super.current,
    required super.hourly,
    required super.daily,
    required super.timezone,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    final current = CurrentWeatherModel.fromJson(json['current'] as Map<String, dynamic>);

    final hourlyJson = json['hourly'] as Map<String, dynamic>;
    final hourlyTimes = (hourlyJson['time'] as List).cast<String>();
    final hourlyTemps = (hourlyJson['temperature_2m'] as List).cast<num>();
    final hourlyPrecip = (hourlyJson['precipitation_probability'] as List);
    final hourlyCodes = (hourlyJson['weather_code'] as List).cast<num>();

    final hourly = <HourlyForecastModel>[
      for (var i = 0; i < hourlyTimes.length; i++)
        HourlyForecastModel(
          time: DateTime.parse(hourlyTimes[i]),
          temperature: hourlyTemps[i].toDouble(),
          condition: WeatherConditionMapper.fromWmoCode(hourlyCodes[i].toInt()),
          precipitationProbability: ((hourlyPrecip[i] as num?) ?? 0).toInt(),
        ),
    ];

    final dailyJson = json['daily'] as Map<String, dynamic>;
    final dailyTimes = (dailyJson['time'] as List).cast<String>();
    final dailyMax = (dailyJson['temperature_2m_max'] as List).cast<num>();
    final dailyMin = (dailyJson['temperature_2m_min'] as List).cast<num>();
    final dailyCodes = (dailyJson['weather_code'] as List).cast<num>();
    final dailySunrise = (dailyJson['sunrise'] as List).cast<String>();
    final dailySunset = (dailyJson['sunset'] as List).cast<String>();
    final dailyPrecip = (dailyJson['precipitation_sum'] as List);

    final daily = <DailyForecastModel>[
      for (var i = 0; i < dailyTimes.length; i++)
        DailyForecastModel(
          date: DateTime.parse(dailyTimes[i]),
          temperatureMax: dailyMax[i].toDouble(),
          temperatureMin: dailyMin[i].toDouble(),
          condition: WeatherConditionMapper.fromWmoCode(dailyCodes[i].toInt()),
          precipitationSum: ((dailyPrecip[i] as num?) ?? 0).toDouble(),
          sunrise: DateTime.parse(dailySunrise[i]),
          sunset: DateTime.parse(dailySunset[i]),
        ),
    ];

    return WeatherForecastModel(
      current: current,
      hourly: hourly,
      daily: daily,
      timezone: json['timezone'] as String? ?? 'UTC',
    );
  }
}
