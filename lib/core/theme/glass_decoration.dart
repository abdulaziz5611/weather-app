import 'package:flutter/material.dart';

import 'app_colors.dart';

class GlassDecoration {
  GlassDecoration._();

  static BoxDecoration card({double radius = 20, bool strong = false}) {
    return BoxDecoration(
      color: strong ? AppColors.glassFillStrong : AppColors.glassFill,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: AppColors.glassBorder, width: 0.5),
    );
  }

  static BoxDecoration pill({bool strong = false}) {
    return BoxDecoration(
      color: strong ? AppColors.glassFillStrong : AppColors.glassFill,
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: AppColors.glassBorder, width: 0.5),
    );
  }
}
