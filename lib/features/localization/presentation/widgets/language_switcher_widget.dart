import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:tatbeeqi/features/localization/presentation/manager/locale_cubit/locale_state.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  const LanguageSwitcherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of supported languages
    final supportedLanguages = [
      {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
      {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
      // Add more languages as needed
    ];

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12.0),
            border:
                Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.locale.languageCode,
              icon: Icon(Icons.language, color: theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(12.0),
              dropdownColor: theme.colorScheme.surface,
              items: supportedLanguages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['code'],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(language['flag']!),
                      const SizedBox(width: 8.0),
                      Text(
                        language['name']!,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? languageCode) {
                if (languageCode != null) {
                  context.read<LocaleCubit>().setLocale(Locale(languageCode));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
