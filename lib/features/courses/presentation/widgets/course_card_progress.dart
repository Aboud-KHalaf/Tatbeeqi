import 'package:flutter/material.dart';
import 'dart:math' as math;

class CourseCardProgress extends StatelessWidget {
  final double progress;
  final String progressText;

  const CourseCardProgress({
    super.key,
    required this.progress,
    required this.progressText,
  });

  List<Color> _getProgressGradientColors(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = HSLColor.fromColor(primaryColor)
        .withSaturation(
            math.min(HSLColor.fromColor(primaryColor).saturation + 0.2, 1.0))
        .withLightness(
            math.max(HSLColor.fromColor(primaryColor).lightness - 0.1, 0.0))
        .toColor();

    return [primaryColor, secondaryColor];
  }

  @override
  Widget build(BuildContext context) {
    if (progress <= 0) {
      return const SizedBox.shrink(); // Don't show if no progress
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withOpacity(0.3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: _getProgressGradientColors(context),
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          progressText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 10.0,
              ),
        ),
      ],
    );
  }
}
