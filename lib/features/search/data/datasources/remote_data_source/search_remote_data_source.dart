import '../../models/city_search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<CitySearchResultModel>> searchCities(String query);
}
