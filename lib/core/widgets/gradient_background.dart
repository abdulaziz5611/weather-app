import 'package:flutter/material.dart';

import '../theme/app_gradients.dart';
import '../utils/time_of_day_helper.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final TimeOfDayPeriod? period;

  const GradientBackground({super.key, required this.child, this.period});

  @override
  Widget build(BuildContext context) {
    final p = period ?? TimeOfDayHelper.current();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      decoration: BoxDecoration(gradient: AppGradients.forPeriod(p)),
      child: child,
    );
  }
}
