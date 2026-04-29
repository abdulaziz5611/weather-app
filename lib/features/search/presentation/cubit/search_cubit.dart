import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/city_search_result.dart';
import '../../domain/usecases/add_recent_search.dart';
import '../../domain/usecases/clear_recent_searches.dart';
import '../../domain/usecases/get_recent_searches.dart';
import '../../domain/usecases/search_cities.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchCities searchCities;
  final GetRecentSearches getRecentSearches;
  final AddRecentSearch addRecentSearch;
  final ClearRecentSearches clearRecentSearches;

  SearchCubit({
    required this.searchCities,
    required this.getRecentSearches,
    required this.addRecentSearch,
    required this.clearRecentSearches,
  }) : super(const SearchIdle()) {
    loadRecents();
  }

  List<CitySearchResult> _currentRecents() {
    final s = state;
    if (s is SearchIdle) return s.recents;
    if (s is SearchLoading) return s.recents;
    return [];
  }

  Future<void> loadRecents() async {
    final result = await getRecentSearches(const NoParams());
    result.fold(
      (_) => emit(const SearchIdle()),
      (recents) => emit(SearchIdle(recents: recents)),
    );
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      await loadRecents();
      return;
    }
    emit(SearchLoading(recents: _currentRecents()));
    final result = await searchCities(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (results) => emit(
        results.isEmpty
            ? SearchEmpty(query)
            : SearchResults(results: results, query: query),
      ),
    );
  }

  Future<void> rememberSelection(CitySearchResult city) async {
    await addRecentSearch(city);
  }

  Future<void> clearRecents() async {
    await clearRecentSearches(const NoParams());
    await loadRecents();
  }
}
