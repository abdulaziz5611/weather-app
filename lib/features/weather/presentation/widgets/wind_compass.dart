import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/glass_card.dart';

class WindCompassCard extends StatelessWidget {
  final double speedKmh;
  final int directionDegrees;

  const WindCompassCard({
    super.key,
    required this.speedKmh,
    required this.directionDegrees,
  });

  String get _cardinal {
    const dirs = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final idx = (((directionDegrees % 360) + 22.5) ~/ 45) % 8;
    return dirs[idx];
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WIND', style: AppTypography.label),
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: CustomPaint(
                painter: _CompassPainter(directionDegrees: directionDegrees),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(speedKmh.round().toString(),
                          style: AppTypography.numericLarge.copyWith(fontSize: 30)),
                      Text('km/h $_cardinal', style: AppTypography.label),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final int directionDegrees;

  _CompassPainter({required this.directionDegrees});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final ringPaint = Paint()
      ..color = AppColors.glassBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius, ringPaint);

    final tickPaint = Paint()
      ..color = AppColors.textMuted
      ..strokeWidth = 1;
    for (var i = 0; i < 24; i++) {
      final angle = (i * 15) * math.pi / 180;
      final outer = Offset(
        center.dx + math.sin(angle) * radius,
        center.dy - math.cos(angle) * radius,
      );
      final inner = Offset(
        center.dx + math.sin(angle) * (radius - (i % 6 == 0 ? 8 : 4)),
        center.dy - math.cos(angle) * (radius - (i % 6 == 0 ? 8 : 4)),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    _drawCardinal(canvas, center, radius, 'N', 0);
    _drawCardinal(canvas, center, radius, 'E', 90);
    _drawCardinal(canvas, center, radius, 'S', 180);
    _drawCardinal(canvas, center, radius, 'W', 270);

    final rad = directionDegrees * math.pi / 180;
    final tip = Offset(
      center.dx + math.sin(rad) * (radius - 14),
      center.dy - math.cos(rad) * (radius - 14),
    );
    final tail = Offset(
      center.dx - math.sin(rad) * (radius - 14) * 0.5,
      center.dy + math.cos(rad) * (radius - 14) * 0.5,
    );
    final arrowPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.accentWarn, AppColors.accentDanger],
      ).createShader(Rect.fromPoints(tail, tip))
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(tail, tip, arrowPaint);

    final headPaint = Paint()..color = AppColors.accentWarn;
    final headPath = Path()..moveTo(tip.dx, tip.dy);
    final perpAngle = rad + math.pi / 2;
    headPath.lineTo(
      tip.dx - math.sin(rad) * 10 + math.cos(perpAngle) * 5,
      tip.dy + math.cos(rad) * 10 + math.sin(perpAngle) * 5,
    );
    headPath.lineTo(
      tip.dx - math.sin(rad) * 10 - math.cos(perpAngle) * 5,
      tip.dy + math.cos(rad) * 10 - math.sin(perpAngle) * 5,
    );
    headPath.close();
    canvas.drawPath(headPath, headPaint);
  }

  void _drawCardinal(Canvas canvas, Offset center, double radius, String label, double deg) {
    final rad = deg * math.pi / 180;
    final pos = Offset(
      center.dx + math.sin(rad) * (radius - 14),
      center.dy - math.cos(rad) * (radius - 14),
    );
    final tp = TextPainter(
      text: TextSpan(text: label, style: AppTypography.label),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_CompassPainter old) => old.directionDegrees != directionDegrees;
}
