import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_state.dart';
// Import your generated AppLocalizations delegate
// Make sure you have run `flutter gen-l10n`
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Adjust path if needed

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to rebuild MaterialApp when locale changes
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          // === Localization Setup ===
          locale: state.locale, // Set locale from Cubit state
          supportedLocales:
              AppLocalizations.supportedLocales, // Locales your app supports
          localizationsDelegates: const [
            AppLocalizations.delegate, // Your generated delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // ==========================
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomePage(), // Your initial screen
        );
      },
    );
  }
}

// Example HomePage and Language Selector
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Use localized string
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.languagePrompt,
            ),
            const SizedBox(height: 20),
            // Example buttons to change language
            ElevatedButton(
              onPressed: () {
                context.read<LocaleCubit>().setLocale(const Locale('en'));
              },
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LocaleCubit>().setLocale(const Locale('ar'));
              },
              child: const Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
