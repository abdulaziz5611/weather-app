import 'dart:convert';

import 'package:hive/hive.dart';

import '../../models/city_search_result_model.dart';
import 'search_local_data_source.dart';

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final Box<String> box;

  static const _key = 'list';
  static const _maxRecents = 5;

  SearchLocalDataSourceImpl(this.box);

  @override
  Future<List<CitySearchResultModel>> getRecents() async {
    final raw = box.get(_key);
    if (raw == null || raw.isEmpty) return [];
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    return list.map(CitySearchResultModel.fromJson).toList();
  }

  @override
  Future<void> addRecent(CitySearchResultModel city) async {
    final current = await getRecents();
    final filtered = current.where((c) => c.id != city.id).toList();
    final updated = [city, ...filtered].take(_maxRecents).toList();
    final json = jsonEncode(updated.map((c) => c.toJson()).toList());
    await box.put(_key, json);
  }

  @override
  Future<void> clearRecents() async {
    await box.delete(_key);
  }
}
