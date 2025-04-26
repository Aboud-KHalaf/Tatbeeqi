import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_state.dart';
import 'package:tatbeeqi/features/navigation/presentation/screens/main_navigation_screen.dart';
// Import the new core theme
import 'package:tatbeeqi/core/theme/app_theme.dart';
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit/theme_cubit.dart';
// Import ThemeCubit (ensure path is correct for theme_mode feature)

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder for LocaleCubit
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        // BlocBuilder for ThemeCubit - state is now ThemeData
        return BlocBuilder<ThemeCubit, ThemeData>(
          // Changed ThemeMode to ThemeData
          builder: (context, currentThemeData) {
            // Changed themeMode to currentThemeData
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              // --- Localization Setup ---
              locale: localeState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,

              // --- Theme Setup ---
              // The theme is now directly controlled by the ThemeData from the Cubit
              theme: currentThemeData,
              // darkTheme is still needed if you want system theme changes to work
              // when ThemeMode.system is potentially re-introduced, but not strictly
              // necessary when the Cubit manages the ThemeData state directly.
              // Keep it for completeness or if system mode might return.
              darkTheme: AppTheme.darkTheme,
              // themeMode is no longer needed here as the Cubit provides the active ThemeData
              // themeMode: themeMode, // REMOVED

              // --- Navigation/Home ---
              home: const MainNavigationScreen(),
              // OR use routes if you have a router setup
              // initialRoute: '/',
              // onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
            );
          },
        );
      },
    );
  }
}
