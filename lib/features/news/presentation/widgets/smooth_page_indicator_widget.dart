import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorWidget extends StatelessWidget {
  const SmoothPageIndicatorWidget({
    super.key,
    required PageController pageController,
    required this.colorScheme,
    required this.newsListlength,
  }) : _pageController = pageController;

  final PageController _pageController;
  final ColorScheme colorScheme;
  final int newsListlength;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: newsListlength,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: colorScheme.primary,
        dotColor: colorScheme.outline.withOpacity(0.3),
        spacing: 6,
      ),
    );
  }
}
