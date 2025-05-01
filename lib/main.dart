import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tatbeeqi/core/di/service_locator.dart' as di;
import 'package:tatbeeqi/core/routing/app_router.dart';

import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_state.dart';
import 'package:tatbeeqi/features/news/presentation/manager/news_cubit.dart';

import 'package:tatbeeqi/features/notifications/presentation/manager/notification_cubit/notification_cubit.dart';
import 'package:tatbeeqi/features/navigation/presentation/manager/navigation_cubit/navigation_cubit.dart';
import 'package:tatbeeqi/features/theme/presentation/manager/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.sl<LocaleCubit>()..getSavedLocale(),
          ),
          BlocProvider(
            create: (_) => di.sl<ThemeCubit>()..loadTheme(),
          ),
          BlocProvider(
            create: (_) =>
                di.sl<NotificationCubit>()..initializeNotifications(),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => di.sl<NewsCubit>()..fetchNews(),
          ),
          BlocProvider(
            create: (_) => di.sl<NavigationCubit>(),
          ),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            final currentLocale = (localeState is LocaleLoaded)
                ? localeState.locale
                : const Locale('en');

            return BlocBuilder<ThemeCubit, ThemeData>(
              builder: (context, currentThemeData) {
                return MaterialApp.router(
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  locale: currentLocale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: currentThemeData,
                );
              },
            );
          },
        ));
  }
}
