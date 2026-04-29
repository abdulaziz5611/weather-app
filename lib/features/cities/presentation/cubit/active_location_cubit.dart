import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/saved_city.dart';
import '../../domain/usecases/get_active_city.dart';
import '../../domain/usecases/set_active_city.dart';

class ActiveLocationCubit extends Cubit<SavedCity> {
  final GetActiveCity getActiveCity;
  final SetActiveCity setActiveCity;

  static const defaultCity = SavedCity(
    id: 'porto-default',
    name: 'Porto',
    country: 'Portugal',
    latitude: 41.1579,
    longitude: -8.6291,
  );

  ActiveLocationCubit({
    required this.getActiveCity,
    required this.setActiveCity,
  }) : super(defaultCity) {
    _init();
  }

  Future<void> _init() async {
    final result = await getActiveCity(const NoParams());
    result.fold(
      (_) {},
      (city) => emit(city ?? defaultCity),
    );
  }

  Future<void> setActive(SavedCity city) async {
    await setActiveCity(city);
    emit(city);
  }
}
