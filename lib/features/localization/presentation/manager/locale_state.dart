import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocaleInitial extends LocaleState {
  // Start with a default locale before loading the saved one
  const LocaleInitial() : super(const Locale('ar'));
}

class LocaleLoaded extends LocaleState {
  const LocaleLoaded(super.locale);
}

class LocaleError extends LocaleState {
  final String message;
  // Keep the last known locale or a default one even in error state
  const LocaleError(super.locale, this.message);

  @override
  List<Object> get props => [locale, message];
}
