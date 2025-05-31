import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/courses/presentation/views/courses_view.dart';
import 'package:tatbeeqi/features/home/presentation/views/home_view.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_cubit.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_state.dart';
import 'package:tatbeeqi/features/navigation/presentation/widgets/fancy_nav_bar_widget.dart';
import 'package:tatbeeqi/features/settings/presentation/screens/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: context.read<NavigationCubit>().state.index);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = const [
    HomeView(),
    CoursesView(),
    SettingsView(),
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (prev, curr) => prev.index != curr.index,
      listener: (context, state) {
        _pageController.animateToPage(
          state.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        // Reset animation when page changes
        _animationController.reset();
        _animationController.forward();
      },
      child: Scaffold(
        extendBody: true, // Important for transparent nav bar
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) =>
              context.read<NavigationCubit>().changeIndex(index),
          physics: const BouncingScrollPhysics(),
          children: _screens,
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return FancyNavBarWidget(
              currentIndex: state.index,
              onTap: (index) {
                HapticFeedback.lightImpact();
                context.read<NavigationCubit>().changeIndex(index);
              },
              animationController: _animationController,
            );
          },
        ),
      ),
    );
  }
}
