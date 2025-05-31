import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card.dart';

class NewsListItem extends StatelessWidget {
  final NewsItemEntity item;
  final int index;
  final PageController pageController;
  final bool isCurrentPage;

  const NewsListItem({
    Key? key,
    required this.item,
    required this.index,
    required this.pageController,
    required this.isCurrentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 1.0;
        if (pageController.position.haveDimensions) {
          value = (pageController.page ?? 0) - index;
          value = (1 - (value.abs() * 0.4)).clamp(0.8, 1.0);
        }
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: NewsCard(
          item: item,
          isSmallScreen: isSmallScreen,
          isCurrentPage: isCurrentPage,
          colorScheme: colorScheme),
    );
  }
}
