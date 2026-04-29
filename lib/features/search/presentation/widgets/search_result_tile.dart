import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/city_search_result.dart';

class SearchResultTile extends StatelessWidget {
  final CitySearchResult city;
  final String query;
  final VoidCallback onTap;

  const SearchResultTile({
    super.key,
    required this.city,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(Icons.location_on_outlined,
                  size: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _highlightedTitle(city.name, query),
                  const SizedBox(height: 2),
                  Text(city.subtitle, style: AppTypography.secondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _highlightedTitle(String name, String query) {
    final lowerName = name.toLowerCase();
    final lowerQuery = query.toLowerCase().trim();
    if (lowerQuery.isEmpty || !lowerName.contains(lowerQuery)) {
      return Text(name, style: AppTypography.body);
    }
    final index = lowerName.indexOf(lowerQuery);
    final before = name.substring(0, index);
    final match = name.substring(index, index + lowerQuery.length);
    final after = name.substring(index + lowerQuery.length);

    return Text.rich(
      TextSpan(children: [
        TextSpan(text: before, style: AppTypography.body),
        TextSpan(
          text: match,
          style: AppTypography.body.copyWith(
            color: AppColors.accentWarn,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(text: after, style: AppTypography.body),
      ]),
    );
  }
}
