import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/glass_decoration.dart';
import '../../domain/entities/city_search_result.dart';

class PopularCitiesGrid extends StatelessWidget {
  final ValueChanged<CitySearchResult> onTap;

  const PopularCitiesGrid({super.key, required this.onTap});

  static const _popular = <CitySearchResult>[
    CitySearchResult(
      id: -1,
      name: 'New York',
      country: 'United States',
      latitude: 40.7128,
      longitude: -74.0060,
    ),
    CitySearchResult(
      id: -2,
      name: 'London',
      country: 'United Kingdom',
      latitude: 51.5074,
      longitude: -0.1278,
    ),
    CitySearchResult(
      id: -3,
      name: 'Dubai',
      country: 'United Arab Emirates',
      latitude: 25.2048,
      longitude: 55.2708,
    ),
    CitySearchResult(
      id: -4,
      name: 'Sydney',
      country: 'Australia',
      latitude: -33.8688,
      longitude: 151.2093,
    ),
    CitySearchResult(
      id: -5,
      name: 'Singapore',
      country: 'Singapore',
      latitude: 1.3521,
      longitude: 103.8198,
    ),
    CitySearchResult(
      id: -6,
      name: 'Paris',
      country: 'France',
      latitude: 48.8566,
      longitude: 2.3522,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('POPULAR CITIES', style: AppTypography.label),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: _popular.length,
          itemBuilder: (context, i) {
            final city = _popular[i];
            return GestureDetector(
              onTap: () => onTap(city),
              child: Container(
                decoration: GlassDecoration.card(radius: 14),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(city.name, style: AppTypography.headline),
                    Text(city.country,
                        style: AppTypography.label
                            .copyWith(color: AppColors.textTertiary)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
