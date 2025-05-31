import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_card_shimmer_loader.dart';

class AllNewsShimmerLoaderList extends StatelessWidget {
  const AllNewsShimmerLoaderList({
    super.key,
    required this.isSmallScreen,
  });

  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return NewsCardShimmerLoader(isSmallScreen: isSmallScreen);
        });
  }
}
