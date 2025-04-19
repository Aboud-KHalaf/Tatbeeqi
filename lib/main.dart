import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/app.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit.dart';

import 'core/di/injection_container.dart';
// Import your generated AppLocalizations delegate
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the LocaleCubit at the top level
    return BlocProvider(
      create: (_) => sl<LocaleCubit>()..getSavedLocale(), // Load initial locale
      child: const AppView(), // Your App's root widget
    );
  }
}
