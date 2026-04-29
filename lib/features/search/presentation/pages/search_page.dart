import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/glass_decoration.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/entities/city_search_result.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/popular_cities_grid.dart';
import '../widgets/recent_searches_list.dart';
import '../widgets/search_result_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) context.read<SearchCubit>().search(q);
    });
  }

  Future<void> _onCityTap(CitySearchResult city) async {
    await context.read<SearchCubit>().rememberSelection(city);
    if (!mounted) return;
    Navigator.of(context).pop(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        period: TimeOfDayPeriod.night,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Search', style: AppTypography.titleLarge),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Cancel',
                        style: AppTypography.body
                            .copyWith(color: AppColors.accentWarn),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _SearchField(
                  controller: _controller,
                  onChanged: _onQueryChanged,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return switch (state) {
                        SearchIdle(:final recents) =>
                          _IdleView(recents: recents, onCityTap: _onCityTap),
                        SearchLoading() => const _LoadingView(),
                        SearchResults(:final results, :final query) =>
                          _ResultsView(
                            results: results,
                            query: query,
                            onCityTap: _onCityTap,
                          ),
                        SearchEmpty(:final query) => _EmptyView(query: query),
                        SearchError(:final message) =>
                          _ErrorView(message: message),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GlassDecoration.pill(),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.search_rounded,
              color: AppColors.textSecondary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTypography.body,
              cursorColor: AppColors.textPrimary,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search for a city or airport',
                hintStyle: AppTypography.secondary,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IdleView extends StatelessWidget {
  final List<CitySearchResult> recents;
  final ValueChanged<CitySearchResult> onCityTap;

  const _IdleView({required this.recents, required this.onCityTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recents.isNotEmpty) ...[
            RecentSearchesList(
              recents: recents,
              onClear: () => context.read<SearchCubit>().clearRecents(),
              onTap: onCityTap,
            ),
            const SizedBox(height: 24),
          ],
          PopularCitiesGrid(onTap: onCityTap),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textPrimary),
      ),
    );
  }
}

class _ResultsView extends StatelessWidget {
  final List<CitySearchResult> results;
  final String query;
  final ValueChanged<CitySearchResult> onCityTap;

  const _ResultsView({
    required this.results,
    required this.query,
    required this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('RESULTS', style: AppTypography.label),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (_, i) => SearchResultTile(
              city: results[i],
              query: query,
              onTap: () => onCityTap(results[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  final String query;
  const _EmptyView({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Text('No matches for "$query".',
            style: AppTypography.body, textAlign: TextAlign.center),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Text(message,
            style: AppTypography.body, textAlign: TextAlign.center),
      ),
    );
  }
}
