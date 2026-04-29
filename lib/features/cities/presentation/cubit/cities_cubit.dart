import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/coordinates.dart';
import '../../../weather/domain/entities/current_weather.dart';
import '../../../weather/domain/usecases/get_weather_forecast.dart';
import '../../domain/entities/saved_city.dart';
import '../../domain/usecases/add_city.dart';
import '../../domain/usecases/get_saved_cities.dart';
import '../../domain/usecases/remove_city.dart';
import '../../domain/usecases/reorder_cities.dart';
import 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  final GetSavedCities getSavedCities;
  final AddCity addCity;
  final RemoveCity removeCity;
  final ReorderCities reorderCities;
  final GetWeatherForecast getWeatherForecast;

  CitiesCubit({
    required this.getSavedCities,
    required this.addCity,
    required this.removeCity,
    required this.reorderCities,
    required this.getWeatherForecast,
  }) : super(const CitiesInitial());

  Future<void> load() async {
    emit(const CitiesLoading());
    final result = await getSavedCities(const NoParams());
    result.fold(
      (failure) => emit(CitiesError(failure.message)),
      (cities) async {
        emit(CitiesLoaded(cities: cities));
        if (cities.isNotEmpty) {
          await _fetchWeatherForCities(cities);
        }
      },
    );
  }

  Future<void> _fetchWeatherForCities(List<SavedCity> cities) async {
    final entries = await Future.wait(cities.map((city) async {
      final result = await getWeatherForecast(
        Coordinates(latitude: city.latitude, longitude: city.longitude),
      );
      return MapEntry<String, CurrentWeather?>(
        city.id,
        result.fold((_) => null, (f) => f.current),
      );
    }));
    final weatherMap = <String, CurrentWeather>{
      for (final e in entries)
        if (e.value != null) e.key: e.value!,
    };
    if (state is CitiesLoaded) {
      emit(CitiesLoaded(cities: cities, weather: weatherMap));
    }
  }

  Future<void> add(SavedCity city) async {
    await addCity(city);
    await load();
  }

  Future<void> remove(String cityId) async {
    await removeCity(cityId);
    await load();
  }
}
