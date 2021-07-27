import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart' show StoreProvider;
import 'package:scoped_model/scoped_model.dart' show ScopedModel;

import './app/app.dart' show App;
import './store/index.dart' show createStore;
import './scope_model/dynamic_model.dart' show DynamicModel;
import './pages/error_page.dart' show ErrorPage;

void main() {
  runZonedGuarded(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return ErrorPage(details);
    };
    runApp(FlutterReduxApp());
  },
  (Object error, StackTrace stack) {
    // Zone中未捕获异常处理回调
    print(error);
    print(stack);
  });
}

class FlutterReduxApp extends StatelessWidget {
  final store = createStore();
  final DynamicModel _dynamicModel = new DynamicModel();

  FlutterReduxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: ScopedModel<DynamicModel>(
        model: _dynamicModel,
        child: App(),
      ),
    );
  }
}
