import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocaleInitial extends LocaleState {
  const LocaleInitial() : super(const Locale('ar'));
}

class LocaleLoaded extends LocaleState {
  const LocaleLoaded(super.locale);
}

class LocaleError extends LocaleState {
  final String message;
  const LocaleError(super.locale, this.message);

  @override
  List<Object> get props => [locale, message];
}
