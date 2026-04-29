import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class UnitSegmentedControl<T> extends StatelessWidget {
  final List<T> options;
  final List<String> labels;
  final T selected;
  final ValueChanged<T> onChanged;

  const UnitSegmentedControl({
    super.key,
    required this.options,
    required this.labels,
    required this.selected,
    required this.onChanged,
  })  : assert(options.length == labels.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < options.length; i++)
            GestureDetector(
              onTap: () => onChanged(options[i]),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: options[i] == selected
                      ? AppColors.glassFillStrong
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  labels[i],
                  style: AppTypography.label.copyWith(
                    color: options[i] == selected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
