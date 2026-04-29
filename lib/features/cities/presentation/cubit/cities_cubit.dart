import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
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

  CitiesCubit({
    required this.getSavedCities,
    required this.addCity,
    required this.removeCity,
    required this.reorderCities,
  }) : super(const CitiesInitial());

  Future<void> load() async {
    emit(const CitiesLoading());
    final result = await getSavedCities(const NoParams());
    result.fold(
      (failure) => emit(CitiesError(failure.message)),
      (cities) => emit(CitiesLoaded(cities)),
    );
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
