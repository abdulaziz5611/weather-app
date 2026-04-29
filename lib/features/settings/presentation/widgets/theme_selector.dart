import 'package:flutter/material.dart';

import '../../domain/entities/unit_preferences.dart';
import 'unit_segmented_control.dart';

class ThemeSelector extends StatelessWidget {
  final AppThemeMode selected;
  final ValueChanged<AppThemeMode> onChanged;

  const ThemeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return UnitSegmentedControl<AppThemeMode>(
      options: const [AppThemeMode.light, AppThemeMode.dark, AppThemeMode.auto],
      labels: const ['Light', 'Dark', 'Auto'],
      selected: selected,
      onChanged: onChanged,
    );
  }
}
