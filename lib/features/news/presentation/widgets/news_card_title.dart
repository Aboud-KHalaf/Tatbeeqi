import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsCardTitle extends StatelessWidget {
  final NewsItemEntity item;
  final bool isCurrentPage;

  const NewsCardTitle({
    Key? key,
    required this.item,
    required this.isCurrentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      item.title,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
