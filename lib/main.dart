import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/app.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit.dart';

import 'core/di/injection_container.dart';
import 'firebase_options.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Use the generated options
  );
  await init(); // Initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provide the LocaleCubit at the top level
    return BlocProvider(
      create: (_) => sl<LocaleCubit>()..getSavedLocale(), // Load initial locale
      child: const AppView(), // Your App's root widget
    );
  }
}

void checkFirebase() async {
  try {
    FirebaseApp app = Firebase.app();
    print('✅ Firebase is ready: ${app.name}');
  } catch (e) {
    print('❌ Firebase not available: $e');
  }
}
