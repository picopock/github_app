import 'package:flutter/material.dart';
import 'package:redux/redux.dart' show combineReducers, TypedReducer;

// action
class ChangeLocaleAction {
  final Locale? locale;

  ChangeLocaleAction({
    @required this.locale,
  });

  @override
  String toString() {
    return 'ChangeLocaleAction{locale: $locale}';
  }
}

// reducer
final localeReducer = combineReducers<Locale>(
  [
    TypedReducer<Locale, ChangeLocaleAction>(_changeLocale),
  ],
);

Locale _changeLocale(Locale locale, ChangeLocaleAction action) {
  locale = action.locale!;
  return locale;
}
