import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsCardDateChip extends StatelessWidget {
  final NewsItemEntity item;

  const NewsCardDateChip({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded,
              size: 12, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            DateFormat.yMMMMd().add_jm().format(item.date),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
