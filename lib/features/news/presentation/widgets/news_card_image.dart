import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';

class NewsCardImage extends StatelessWidget {
  final NewsItemEntity item;
  final bool isSmallScreen;

  const NewsCardImage({
    Key? key,
    required this.item,
    required this.isSmallScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        width: isSmallScreen ? 70 : 90,
        height: isSmallScreen ? 70 : 90,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.image_not_supported,
              size: isSmallScreen ? 30 : 40,
              color: colorScheme.outline,
            ),
          ),
        ),
      ),
    );
  }
}
