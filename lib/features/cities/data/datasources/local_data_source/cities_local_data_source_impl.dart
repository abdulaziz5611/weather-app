import 'dart:convert';

import 'package:hive/hive.dart';

import '../../models/saved_city_model.dart';
import 'cities_local_data_source.dart';

class CitiesLocalDataSourceImpl implements CitiesLocalDataSource {
  final Box<String> box;

  static const _key = 'list';
  static const _activeKey = 'active';

  CitiesLocalDataSourceImpl(this.box);

  @override
  Future<List<SavedCityModel>> getCities() async {
    final raw = box.get(_key);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(SavedCityModel.fromJson).toList();
  }

  @override
  Future<void> addCity(SavedCityModel city) async {
    final current = await getCities();
    if (current.any((c) => c.id == city.id)) return;
    final updated = [...current, city];
    await setCities(updated);
  }

  @override
  Future<void> removeCity(String cityId) async {
    final current = await getCities();
    final updated = current.where((c) => c.id != cityId).toList();
    await setCities(updated);
  }

  @override
  Future<void> setCities(List<SavedCityModel> cities) async {
    final json = jsonEncode(cities.map((c) => c.toJson()).toList());
    await box.put(_key, json);
  }

  @override
  Future<SavedCityModel?> getActiveCity() async {
    final raw = box.get(_activeKey);
    if (raw == null || raw.isEmpty) return null;
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return SavedCityModel.fromJson(json);
  }

  @override
  Future<void> setActiveCity(SavedCityModel city) async {
    await box.put(_activeKey, jsonEncode(city.toJson()));
  }
}
