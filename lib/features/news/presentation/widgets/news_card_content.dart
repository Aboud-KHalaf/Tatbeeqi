import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_date_chip.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_description.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_image.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_title.dart';

class NewsCardContent extends StatelessWidget {
  final NewsItemEntity item;
  final bool isSmallScreen;
  final bool isCurrentPage;

  const NewsCardContent({
    Key? key,
    required this.item,
    required this.isSmallScreen,
    required this.isCurrentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewsCardDateChip(item: item),
                const SizedBox(height: 12.0),
                NewsCardTitle(item: item, isCurrentPage: isCurrentPage),
                const SizedBox(height: 8.0),
                NewsCardDescription(item: item, isSmallScreen: isSmallScreen),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          NewsCardImage(item: item, isSmallScreen: isSmallScreen),
        ],
      ),
    );
  }
}
