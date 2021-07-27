import 'package:flutter/material.dart';
import 'package:redux/redux.dart' show combineReducers, TypedReducer;

class ChangeThemeDataAction {
  final ThemeData themeData;

  ChangeThemeDataAction({
    required this.themeData,
  });

  @override
  String toString() {
    return 'ChangeThemeDataAction{themeData: $themeData}';
  }
}

final themeDataReducer = combineReducers<ThemeData>(
  [TypedReducer<ThemeData, ChangeThemeDataAction>(_changeThemeData)],
);

ThemeData _changeThemeData(ThemeData themeData, ChangeThemeDataAction action) {
  themeData = action.themeData;
  return themeData;
}
