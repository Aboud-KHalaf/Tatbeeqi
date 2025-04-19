import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart'; // Dependency Injection setup

import 'features/theme/presentation/manager/theme_cubit.dart';
import 'features/theme/presentation/widgets/theme_toggle_widget.dart'; // Import GetIt

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await init();

  // Optional: Pre-load the theme before the app starts
  // This avoids a flicker if the initial state (system) differs from saved state
  // final initialTheme = await di.sl<GetThemeModeUseCase>()(); // Load theme via DI
  // Or load within the Cubit using an init method called after providing

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the ThemeCubit at the top of the widget tree
    return BlocProvider(
      // Use the GetIt instance to create the ThemeCubit
      create: (_) => sl<ThemeCubit>()
        ..loadThemeMode(), // Load initial theme when Cubit is created
      child: const App(), // Your main App widget
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder listens to ThemeCubit state changes and rebuilds MaterialApp
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Theme Toggle App',
          // Define your light and dark themes
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            // ... other light theme properties
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            // ... other dark theme properties
          ),
          // Set the themeMode based on the Cubit's state
          themeMode: themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Example'),
        actions: const [
          ThemeToggleWidget(), // Add the toggle button/icon
        ],
      ),
      body: const Center(
        child: Text('Toggle the theme using the button in the AppBar!'),
      ),
    );
  }
}
