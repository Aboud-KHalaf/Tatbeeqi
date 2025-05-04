import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tatbeeqi/features/home/presentation/views/home_view.dart';
import 'package:tatbeeqi/features/navigation/presentation/screens/main_navigation_screen.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/presentation/views/all_news_view.dart';
import 'package:tatbeeqi/features/news/presentation/views/news_details_view.dart';
import 'package:tatbeeqi/features/settings/presentation/screens/settings_screen.dart';
import 'package:tatbeeqi/features/todo/presentation/views/todo_view.dart';

final GoRouter router = GoRouter(
  initialLocation: HomeView.routePath,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const MainNavigationScreen();
      },
    ),
    GoRoute(
      path: SettingsView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsView();
      },
    ),
    GoRoute(
      path: AllNewsView.routeId,
      builder: (BuildContext context, GoRouterState state) {
        return const AllNewsView();
      },
    ),
    GoRoute(
      path: TodoView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const TodoView();
      },
    ),
    GoRoute(
      path: NewsDetailsView.routeId,
      name: 'newsDetails',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        final newsItem = args['newsItem'] as NewsItemEntity;
        final heroTag = args['heroTag'] as String;

        return NewsDetailsView(newsItem: newsItem, heroTag: heroTag);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(child: Text('Route not found: ${state.error}')),
  ),
);
