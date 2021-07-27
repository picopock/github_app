import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show Intl;
import './messages_all.dart' show initializeMessages;

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  String get title =>
      Intl.message('Flutter App', desc: 'Title for the Demo application');

  String get tabBarItemNameDynamic =>
      Intl.message('Dynamic', desc: 'tabBar item name: dynamic');

  String get tabBarItemNameTrend {
    return Intl.message('Trend', desc: 'tabBar item name: dynamic');
  }

  String get tabBarItemNameMine =>
      Intl.message('Mine', desc: 'tabBar item name: mine');

  String get languageToggle {
    return Intl.message('Language Toggle', desc: 'language toggle');
  }

  String get themeToggle {
    return Intl.message('Theme Toggle', desc: 'theme toggle');
  }

  String get userInfo => Intl.message('User Info', desc: 'user info');
  String get about => Intl.message('About', desc: 'about');
  String get checkForUpdates =>
      Intl.message('Check for updates', desc: 'Check for updates');
  String get feedback => Intl.message('Feedback', desc: 'feedback');
  String get readingHistory =>
      Intl.message('Reading history', desc: 'Reading history');
  String get signout => Intl.message('Sign Out', desc: 'sign out');

  String get loginUsernameHint =>
      Intl.message('Please input username', desc: 'login username');
  String get loginPasswordHint =>
      Intl.message('Please input password', desc: 'login password');
  String get login => Intl.message('Login', desc: 'login button');
  String get loading => Intl.message('Loading...', desc: 'loading');

  String get appName =>
      Intl.message('Github App', name: 'appName', desc: 'github app');

  String appVersion(version) {
    return Intl.message('version: $version',
        name: 'appVersion', args: [version], desc: 'version: version');
  }

  String get noData =>
      Intl.message('No Data!', name: 'noData', desc: 'No Data!');

  String get loadingMore =>
      Intl.message('loading...', name: 'loadingMore', desc: 'loading...');

  String get daily => Intl.message('Daily', name: 'daily', desc: 'daily');

  String get weekly => Intl.message('Weekly', name: 'weekly', desc: 'weekly');

  String get monthly =>
      Intl.message('monthly', name: 'monthly', desc: 'monthly');

  String get trendAll =>
      Intl.message('Trend All', name: 'trendAll', desc: 'trend all');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  // 是否支持某个 locale
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
