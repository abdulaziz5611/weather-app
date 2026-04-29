import '../../models/saved_city_model.dart';

abstract class CitiesLocalDataSource {
  Future<List<SavedCityModel>> getCities();
  Future<void> addCity(SavedCityModel city);
  Future<void> removeCity(String cityId);
  Future<void> setCities(List<SavedCityModel> cities);

  Future<SavedCityModel?> getActiveCity();
  Future<void> setActiveCity(SavedCityModel city);
}
