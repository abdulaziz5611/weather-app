import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/glass_decoration.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../search/domain/entities/city_search_result.dart';
import '../../domain/entities/saved_city.dart';
import '../cubit/active_location_cubit.dart';
import '../cubit/cities_cubit.dart';
import '../cubit/cities_state.dart';
import '../widgets/city_card.dart';

class MyCitiesPage extends StatefulWidget {
  const MyCitiesPage({super.key});

  @override
  State<MyCitiesPage> createState() => _MyCitiesPageState();
}

class _MyCitiesPageState extends State<MyCitiesPage> {
  @override
  void initState() {
    super.initState();
    context.read<CitiesCubit>().load();
  }

  Future<void> _addCity() async {
    final picked =
        await Navigator.of(context).pushNamed<Object?>(RouteNames.search);
    if (!mounted || picked == null || picked is! CitySearchResult) return;
    final saved = SavedCity(
      id: '${picked.latitude.toStringAsFixed(4)}_${picked.longitude.toStringAsFixed(4)}',
      name: picked.name,
      country: picked.country,
      admin1: picked.admin1,
      latitude: picked.latitude,
      longitude: picked.longitude,
      timezone: picked.timezone,
    );
    if (!mounted) return;
    await context.read<CitiesCubit>().add(saved);
    if (!mounted) return;
    await context.read<ActiveLocationCubit>().setActive(saved);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _selectCity(SavedCity city) async {
    await context.read<ActiveLocationCubit>().setActive(city);
    if (!mounted) return;
    Navigator.of(context).pop();
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
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Done',
                        style: AppTypography.body
                            .copyWith(color: AppColors.accentWarn),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(RouteNames.settings),
                      child: Container(
                        decoration: GlassDecoration.pill(),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.settings_outlined,
                            color: AppColors.textPrimary, size: 22),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _addCity,
                      child: Container(
                        decoration: GlassDecoration.pill(),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.add_rounded,
                            color: AppColors.textPrimary, size: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('My Cities', style: AppTypography.titleLarge),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<CitiesCubit, CitiesState>(
                    builder: (context, state) {
                      return switch (state) {
                        CitiesInitial() || CitiesLoading() => const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.textPrimary),
                            ),
                          ),
                        CitiesLoaded(:final cities, :final weather) =>
                          cities.isEmpty
                              ? _EmptyView(onAdd: _addCity)
                              : RefreshIndicator(
                                  color: AppColors.textPrimary,
                                  backgroundColor: AppColors.background,
                                  onRefresh: () =>
                                      context.read<CitiesCubit>().load(),
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 32),
                                    children: cities
                                        .map((c) => Dismissible(
                                              key: ValueKey(c.id),
                                              direction:
                                                  DismissDirection.endToStart,
                                              background: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                margin: const EdgeInsets.only(
                                                    bottom: 12),
                                                padding: const EdgeInsets.only(
                                                    right: 24),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.accentDanger,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20),
                                                ),
                                                child: const Icon(
                                                  Icons
                                                      .delete_outline_rounded,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              onDismissed: (_) => context
                                                  .read<CitiesCubit>()
                                                  .remove(c.id),
                                              child: CityCard(
                                                city: c,
                                                weather: weather[c.id],
                                                onTap: () => _selectCity(c),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                        CitiesError(:final message) => Center(
                            child: Text(message,
                                style: AppTypography.body,
                                textAlign: TextAlign.center),
                          ),
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

class _EmptyView extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyView({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_city_rounded,
                size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text('No cities yet.', style: AppTypography.headline),
            const SizedBox(height: 8),
            Text('Tap + to search and add cities.',
                style: AppTypography.secondary, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onAdd,
              child: Text('Add a city', style: AppTypography.body),
            ),
          ],
        ),
      ),
    );
  }
}
