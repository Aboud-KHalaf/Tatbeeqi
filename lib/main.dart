import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/app.dart';
// Updated import:
import 'package:tatbeeqi/core/di/service_locator.dart' as di; // Use alias
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart'; // Ensure correct path
import 'package:tatbeeqi/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart'; // Import Notification Cubit
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_cubit.dart'; // Import Navigation Cubit
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit/theme_cubit.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart'; // Import generated Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- Initialize Firebase ---
  // Ensure you have run `flutterfire configure` and have firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // --- Initialize Dependency Injection ---
  await di.init(); // Initialize dependencies using the new setup

  // --- Run App ---
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide all necessary Blocs/Cubits at the top level
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<LocaleCubit>()..getSavedLocale(),
        ),
        BlocProvider(
          create: (_) => di.sl<ThemeCubit>()
            ..loadTheme(), // Changed from loadThemeMode to loadTheme
        ),
        BlocProvider(
          // Create NotificationCubit and initialize notifications
          create: (_) => di.sl<NotificationCubit>()..initializeNotifications(),
          lazy: false, // Initialize immediately
        ),
        BlocProvider(
          // Add Navigation Cubit Provider
          create: (_) => di.sl<NavigationCubit>(),
        ),
        // Add other global providers here
      ],
      child: const AppView(), // Your App's root widget (contains MaterialApp)
    );
  }
}
