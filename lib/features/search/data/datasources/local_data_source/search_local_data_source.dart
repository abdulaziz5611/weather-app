import '../../models/city_search_result_model.dart';

abstract class SearchLocalDataSource {
  Future<List<CitySearchResultModel>> getRecents();
  Future<void> addRecent(CitySearchResultModel city);
  Future<void> clearRecents();
}
