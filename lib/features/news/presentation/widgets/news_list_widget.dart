import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_list_item.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({
    super.key,
    required this.isSmallScreen,
    required PageController pageController,
    required int currentPage,
    required this.newsList,
  })  : _pageController = pageController,
        _currentPage = currentPage;

  final bool isSmallScreen;
  final PageController _pageController;
  final int _currentPage;
  final List<NewsItemEntity> newsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmallScreen ? 160 : 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final item = newsList[index];
          final isCurrentPage = index == _currentPage;
          return NewsListItem(
            item: item,
            index: index,
            pageController: _pageController,
            isCurrentPage: isCurrentPage,
          );
        },
      ),
    );
  }
}
