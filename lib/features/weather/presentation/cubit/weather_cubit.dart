import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/coordinates.dart';
import '../../domain/usecases/get_air_quality.dart';
import '../../domain/usecases/get_weather_forecast.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherForecast getWeatherForecast;
  final GetAirQuality getAirQuality;

  WeatherCubit({
    required this.getWeatherForecast,
    required this.getAirQuality,
  }) : super(const WeatherInitial());

  Future<void> loadForecast(Coordinates coords) async {
    emit(const WeatherLoading());

    final forecastResult = await getWeatherForecast(coords);

    await forecastResult.fold(
      (failure) async => emit(WeatherError(failure.message)),
      (forecast) async {
        final aqResult = await getAirQuality(coords);
        emit(aqResult.fold(
          (_) => WeatherLoaded(forecast: forecast),
          (aq) => WeatherLoaded(forecast: forecast, airQuality: aq),
        ));
      },
    );
  }
}
