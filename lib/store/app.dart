import 'package:flutter/material.dart';

import './locale.dart' show localeReducer;
import './theme_data.dart' show themeDataReducer;
import '../model/user.dart' show User;
import '../store/user.dart' show userReducer;
import '../store/login.dart' show loginReducer;

class AppState {
  User? userInfo;
  Locale locale;
  ThemeData themeData;
  bool login;

  AppState({
    required this.userInfo,
    required this.locale,
    required this.themeData,
    required this.login,
  });
}

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    locale: localeReducer(state.locale, action),
    themeData: themeDataReducer(state.themeData, action),
    userInfo: userReducer(state.userInfo, action),
    login: loginReducer(state.login, action),
  );
}

final AppState initialState = AppState(
  locale: Locale('zh', 'CN'),
  themeData: ThemeData(),
  login: false,
  userInfo: null,
);
