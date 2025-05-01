import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsCardDescription extends StatelessWidget {
  final NewsItemEntity item;
  final bool isSmallScreen;

  const NewsCardDescription({
    Key? key,
    required this.item,
    required this.isSmallScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      item.description,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      maxLines: isSmallScreen ? 1 : 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
