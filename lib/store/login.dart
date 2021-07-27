import 'package:flutter/material.dart' hide Router;
import 'package:redux/redux.dart' show combineReducers, TypedReducer;
import '../route/index.dart' show Router;

final loginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginSuccessAction>(_loginResult),
  TypedReducer<bool, LogoutAction>(_logoutResult),
]);

class LoginAction {
  final BuildContext context;
  final String username;
  final String password;

  LoginAction(this.context, this.username, this.password);

  @override
  String toString() {
    return 'ChangeLocaleAction{context: $context, username: $username, password: $password}';
  }
}

class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}

bool _loginResult(bool result, LoginSuccessAction action) {
  if (action.success == true) {
    Router.goHome(action.context);
  }
  return action.success;
}

class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

bool _logoutResult(bool result, LogoutAction action) {
  return false;
}
