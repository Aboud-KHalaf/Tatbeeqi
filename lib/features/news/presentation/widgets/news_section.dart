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
  late final PageController _pageController;
  late final AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() => _currentPage = page);
    }
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadedState) {
          return _buildNewsContent(context, state);
        } else if (state is NewsErrorState) {
          AppLogger.error(state.message);
          return const Icon(Icons.error, size: 48);
        } else {
          return NewsCardShimmerLoader(isSmallScreen: isSmallScreen);
        }
      },
    );
  }

  Widget _buildNewsContent(BuildContext context, NewsLoadedState state) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        NewsListWidget(
          newsList: state.newsItems,
          isSmallScreen: MediaQuery.of(context).size.width < 360,
          pageController: _pageController,
          currentPage: _currentPage,
        ),
        const SizedBox(height: 16),
        SmoothPageIndicatorWidget(
          newsListlength: state.newsItems.length,
          pageController: _pageController,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}
