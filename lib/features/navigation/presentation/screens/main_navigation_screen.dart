import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_cubit.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_state.dart';
import 'package:tatbeeqi/features/navigation/presentation/widgets/bottom_nav_bar.dart';
import 'package:tatbeeqi/features/home/presentation/views/home_view.dart';
import 'package:tatbeeqi/features/settings/presentation/screens/settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: context.read<NavigationCubit>().state.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = const [
    HomeView(),
    SettingsView(),
    HomeView(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (prev, curr) => prev.index != curr.index,
      listener: (context, state) {
        _pageController.jumpToPage(state.index);
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) =>
              context.read<NavigationCubit>().changeIndex(index),
          physics: const BouncingScrollPhysics(),
          children: _screens, // Nice swipe feel
        ),
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return AppBottomNavBar(
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<NavigationCubit>().changeIndex(index),
            );
          },
        ),
      ),
    );
  }
}
