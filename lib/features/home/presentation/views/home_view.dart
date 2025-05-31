import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tatbeeqi/core/constants/constants.dart';
import 'package:tatbeeqi/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:tatbeeqi/features/home/presentation/widgets/recently_added_section.dart';
import 'package:tatbeeqi/features/home/presentation/widgets/study_progress_section.dart';
import 'package:tatbeeqi/features/news/presentation/views/all_news_view.dart';
import 'package:tatbeeqi/features/news/presentation/widgets/news_section.dart';
import 'package:tatbeeqi/features/todo/presentation/views/todo_view.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/today_tasks_section.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  static String routePath = '/homeView';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomHomeAppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
        children: [
          _SectionTitle(
            title: l10n.homeLatestNewsAndEvents,
            onPressed: () {
              context.push(AllNewsView.routeId);
            },
          ),
          const SizedBox(height: 12.0),
          const NewsSection(),
          const SizedBox(height: 28.0),
          _SectionTitle(
              title: l10n.homeTodayTasks,
              onPressed: () {
                context.push(TodoView.routePath);
              }),
          const SizedBox(height: 12.0),
          const TodayTasksSection(),
          const SizedBox(height: 28.0),
          _SectionTitle(title: l10n.homeContinueStudying, onPressed: () {}),
          const SizedBox(height: 12.0),
          const StudyProgressSection(),
          const SizedBox(height: .0),
          _SectionTitle(title: l10n.homeRecentlyAdded, onPressed: () {}),
          const SizedBox(height: 12.0),
          const RecentlyAddedSection(),
          const SizedBox(height: AppConstants.totalBottomPaddingForContent),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const _SectionTitle({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: Text(
              l10n.seeAll,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
