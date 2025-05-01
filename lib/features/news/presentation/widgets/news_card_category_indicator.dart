import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsCardCategoryIndicator extends StatelessWidget {
  final NewsItemEntity item;

  const NewsCardCategoryIndicator({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return PositionedDirectional(
      top: 0,
      end: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getCategoryColor(item.category, colorScheme),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Text(
          _getCategoryText(item.category),
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category, ColorScheme colorScheme) {
    switch (category.toLowerCase()) {
      case 'event':
        return Colors.orange;
      case 'news':
        return Colors.blue;
      case 'announcement':
        return Colors.green;
      default:
        return colorScheme.primary;
    }
  }

  String _getCategoryText(String category) {
    return category.isNotEmpty ? category : 'News';
  }
}
