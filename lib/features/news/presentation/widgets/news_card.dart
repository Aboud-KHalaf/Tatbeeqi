import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/views/news_details_view.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_category_indicator.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_content.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.item,
    required this.isSmallScreen,
    required this.isCurrentPage,
    required this.colorScheme,
  });

  final NewsItemEntity item;
  final bool isSmallScreen;
  final bool isCurrentPage;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          NewsDetailsView.routeId,
          extra: {
            'newsItem': item,
            'heroTag': 'news_${item.id}',
          },
        );
      },
      child: Hero(
        tag: 'news_${item.id}',
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 2 : 4),
          child: Card(
            elevation: isCurrentPage ? 4.0 : 2.0,
            shadowColor: colorScheme.shadow.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: colorScheme.surface,
            child: Stack(
              children: [
                NewsCardContent(
                  item: item,
                  isCurrentPage: isCurrentPage,
                  isSmallScreen: isSmallScreen,
                ),
                NewsCardCategoryIndicator(item: item),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
