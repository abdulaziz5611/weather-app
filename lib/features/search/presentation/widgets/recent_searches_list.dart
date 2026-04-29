import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/city_search_result.dart';

class RecentSearchesList extends StatelessWidget {
  final List<CitySearchResult> recents;
  final VoidCallback onClear;
  final ValueChanged<CitySearchResult> onTap;

  const RecentSearchesList({
    super.key,
    required this.recents,
    required this.onClear,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (recents.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('RECENT', style: AppTypography.label),
              GestureDetector(
                onTap: onClear,
                child: Text('CLEAR',
                    style: AppTypography.label
                        .copyWith(color: AppColors.accentWarn)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        ...recents.map(
          (c) => InkWell(
            onTap: () => onTap(c),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.history_rounded,
                      size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Expanded(child: Text(c.name, style: AppTypography.body)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
