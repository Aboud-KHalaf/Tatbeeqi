import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_state.dart';
// Import your generated AppLocalizations delegate
// Make sure you have run `flutter gen-l10n`
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tatbeeqi/features/navigation/presentation/screens/main_navigation_screen.dart'; // Import MainNavigationScreen
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit.dart'; // Import ThemeCubit if not already

// Remove NotificationCubit import if not directly used here
// import 'package:tatbeeqi/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder for LocaleCubit
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        // Use BlocBuilder for ThemeCubit
        return BlocBuilder<ThemeCubit, ThemeMode>(
          // Add ThemeCubit builder
          builder: (context, themeMode) {
            return MaterialApp(
              // === Localization Setup ===
              locale: localeState.locale, // Set locale from Cubit state
              supportedLocales: AppLocalizations
                  .supportedLocales, // Locales your app supports
              localizationsDelegates: const [
                AppLocalizations.delegate, // Your generated delegate
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // ==========================

              // === Theme Setup ===
              themeMode: themeMode, // Set theme mode from Cubit state
              theme: ThemeData(
                // Define your light theme
                brightness: Brightness.light,
                // Add other light theme properties
              ),
              darkTheme: ThemeData(
                // Define your dark theme
                brightness: Brightness.dark,
                // Add other dark theme properties
              ),
              // ===================

              debugShowCheckedModeBanner: false, // Optional: hide debug banner

              // === Set Home Screen ===
              home:
                  const MainNavigationScreen(), // Use the main navigation screen
              // =======================

              // --- Optional: Routing ---
              // If you have named routes, define them here
              // routes: {
              //   '/some_route': (context) => SomeScreen(),
              // },
              // -------------------------
            );
          },
        );
      },
    );
  }
}
