import 'package:dio/dio.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/city_search_result_model.dart';
import 'search_remote_data_source.dart';

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CitySearchResultModel>> searchCities(String query) async {
    try {
      final response = await dio.get(
        '${ApiConstants.openMeteoGeocodingUrl}/search',
        queryParameters: {
          'name': query,
          'count': 10,
          'language': 'en',
          'format': 'json',
        },
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final results = (data['results'] as List?) ?? [];
        return results
            .cast<Map<String, dynamic>>()
            .map(CitySearchResultModel.fromJson)
            .toList();
      }
      throw const ServerException();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
