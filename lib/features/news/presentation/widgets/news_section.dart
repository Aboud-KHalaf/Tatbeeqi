import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';
import 'package:tatbeeqi/features/news/presentation/manager/news_cubit.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_shimmer_loader.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_list_widget.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/smooth_page_indicator_widget.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page?.round() ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadedState) {
          return Column(
            children: [
              NewsListWidget(
                newsList: state.newsItems,
                isSmallScreen: isSmallScreen,
                pageController: _pageController,
                currentPage: _currentPage,
              ),
              const SizedBox(height: 16.0),
              SmoothPageIndicatorWidget(
                newsListlength: state.newsItems.length,
                pageController: _pageController,
                colorScheme: colorScheme,
              ),
            ],
          );
        } else if (state is NewsErrorState) {
          AppLogger.error(state.message);
          return const Icon(Icons.error);
        } else {
          return NewsCardShimmerLoader(isSmallScreen: isSmallScreen);
        }
      },
    );
  }
}
