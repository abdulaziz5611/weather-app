import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';

class SunMoonCard extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const SunMoonCard({super.key, required this.sunrise, required this.sunset});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SUN', style: AppTypography.label),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SunItem(
                icon: Icons.wb_twilight_rounded,
                label: 'Sunrise',
                time: sunrise,
                color: AppColors.accentWarn,
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.glassBorder,
              ),
              _SunItem(
                icon: Icons.nightlight_round,
                label: 'Sunset',
                time: sunset,
                color: AppColors.accentInfo,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SunItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime time;
  final Color color;

  const _SunItem({
    required this.icon,
    required this.label,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(label, style: AppTypography.label),
        const SizedBox(height: 4),
        Text(
          _format(time),
          style: AppTypography.numeric.copyWith(fontSize: 16),
        ),
      ],
    );
  }

  String _format(DateTime t) {
    final h = t.hour == 0 ? 12 : (t.hour > 12 ? t.hour - 12 : t.hour);
    final m = t.minute.toString().padLeft(2, '0');
    final p = t.hour < 12 ? 'AM' : 'PM';
    return '$h:$m $p';
  }
}
