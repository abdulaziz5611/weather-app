import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/glass_decoration.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool strong;
  final double blur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 20,
    this.strong = false,
    this.blur = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: GlassDecoration.card(radius: radius, strong: strong),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
