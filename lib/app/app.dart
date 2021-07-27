import 'package:flutter/material.dart';
import 'package:redux/redux.dart' show Store;
import 'package:flutter_redux/flutter_redux.dart' show StoreBuilder;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations, GlobalWidgetsLocalizations;

import '../i10n/localization_intl.dart' show AppLocalizations;
import '../store/app.dart' show AppState;
import '../pages/welcome.dart' show WelcomePage;
import '../pages/home/home_page.dart' show HomePage;
import '../pages/login/login_page.dart' show LoginPage;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        return MaterialApp(
          onGenerateTitle: (context) {
            return AppLocalizations.of(context).title;
          },
          theme: store.state.themeData,
          locale: store.state.locale,
          localizationsDelegates: [
            // 本地化的代理类
            // 需要引入flutter_localizations
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // 自定义代理
            AppLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // 美式英语
            const Locale('zh', 'CN'), // 中文简体
            //其它Locales
          ],
          routes: {
            '/': (BuildContext context) {
              return WelcomePage();
            },
            HomePage.path: (BuildContext context) {
              return HomePage();
            },
            LoginPage.path: (BuildContext context) {
              return LoginPage();
            },
          },
        );
      },
    );
  }
}
