import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_state.dart';

class LanguageSwitcherButton extends StatelessWidget {
  const LanguageSwitcherButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        // Simple toggle between English and Arabic
        final isEnglish = state.locale.languageCode == 'en';
        final nextLocale = isEnglish ? const Locale('ar') : const Locale('en');
        final nextLanguageName = isEnglish ? 'العربية' : 'English';

        return IconButton(
          onPressed: () => context.read<LocaleCubit>().setLocale(nextLocale),
          tooltip: 'Switch to $nextLanguageName',
          icon: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.language,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isEnglish ? 'ar' : 'en',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
