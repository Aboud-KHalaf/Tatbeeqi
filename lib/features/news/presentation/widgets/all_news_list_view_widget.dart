import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card.dart';

class AllNewsListViewWidget extends StatelessWidget {
  const AllNewsListViewWidget({
    super.key,
    required this.isSmallScreen,
    required this.colorScheme,
    required this.news,
  });

  final List<NewsItemEntity> news;
  final bool isSmallScreen;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final item = news[index];
        return NewsCard(
          item: item,
          isCurrentPage: true,
          isSmallScreen: isSmallScreen,
          colorScheme: colorScheme,
        );
      },
    );
  }
}
