import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart' show StoreBuilder;
import 'package:redux/redux.dart' show Store;
import 'package:package_info/package_info.dart' show PackageInfo;

import '../../../i10n/localization_intl.dart' show AppLocalizations;
import '../../../store/app.dart' show AppState;
import '../../../store/theme_data.dart' show ChangeThemeDataAction;
import '.././../../style/index.dart' show Constant, CustomICons;
import '../../../widgets/language_dialog.dart' show LanguageDialog;
import '../../../store/locale.dart' show ChangeLocaleAction;
import '../../../widgets/theme_dialog.dart' show ThemeDialog;
import '../../../store/login.dart' show LogoutAction;
import '../../../model/user.dart' show User;
// import '../../../route/index.dart' show Router;

class HomeDrawer extends StatelessWidget {
  Future<LanguageDialog?> showLanguageDialog(
      BuildContext context, Store<AppState> store) {
    Function onPressed(Locale locale) {
      return () {
        store.dispatch(ChangeLocaleAction(locale: locale));
        Navigator.pop(context);
      };
    }

    return showDialog<LanguageDialog>(
      context: context,
      builder: (BuildContext context) {
        return LanguageDialog(onPressed: onPressed);
      },
    );
  }

  Future<ThemeDialog?> showThemeDialog(
      BuildContext context, Store<AppState> store) {
    Function onPressed(Color color) {
      final ThemeData themeData = ThemeData(primaryColor: color);
      return () {
        store.dispatch(ChangeThemeDataAction(themeData: themeData));
        Navigator.pop(context);
      };
    }

    return showDialog<ThemeDialog>(
      context: context,
      builder: (BuildContext context) {
        return ThemeDialog(onPressed: onPressed);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreBuilder<AppState>(
        builder: (BuildContext context, Store<AppState> store) {
          final User? user = store.state.userInfo;
          return Drawer(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        user?.name ?? '',
                        style: Constant.largeTextWhite,
                      ),
                      accountEmail: Text(
                        user?.login ?? '',
                        style: Constant.normalTextLight,
                      ),
                      currentAccountPicture: GestureDetector(
                        onTap: () {},
                        child: ClipOval(
                          child: FadeInImage(
                            placeholder:
                                AssetImage(CustomICons.DEFAULT_USER_ICON),
                            image: NetworkImage(
                              user?.avatarUrl ?? CustomICons.DEFAULT_USER_ICON,
                            ),
                            // 预览图
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: store.state.themeData.primaryColor,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        AppLocalizations.of(context).userInfo,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showLanguageDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text(
                        AppLocalizations.of(context).readingHistory,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showLanguageDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.language),
                      title: Text(
                        AppLocalizations.of(context).languageToggle,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showLanguageDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.color_lens),
                      title: Text(
                        AppLocalizations.of(context).themeToggle,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showThemeDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text(
                        AppLocalizations.of(context).feedback,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showLanguageDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.system_update),
                      title: Text(
                        AppLocalizations.of(context).checkForUpdates,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        showLanguageDialog(context, store);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        AppLocalizations.of(context).about,
                        style: Constant.normalText,
                      ),
                      onTap: () {
                        // showLanguageDialog(context, store);
                        PackageInfo.fromPlatform()
                            .then((PackageInfo packageInfo) {
                          showAboutDialog(
                            context: context,
                            applicationIcon: Image.network(
                              user?.avatarUrl ?? CustomICons.DEFAULT_REMOTE_PIC,
                              width: 50.0,
                              height: 50.0,
                            ),
                            applicationName:
                                AppLocalizations.of(context).appName,
                            applicationVersion: AppLocalizations.of(context)
                                .appVersion(packageInfo.version),
                            applicationLegalese: 'http://github.com/xinsui01',
                          );
                        });
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Builder(
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      textStyle:
                                          TextStyle(color: Colors.white)),
                                  child: Text(
                                    AppLocalizations.of(context).signout,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  onPressed: () {
                                    store.dispatch(LogoutAction(context));
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
