import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart' show StoreBuilder;
import 'package:redux/redux.dart' show Store;

import '../../store/app.dart' show AppState;
import '../../style/index.dart' show CustomColors, CustomICons;
import '../../widgets/input_widget.dart' show CustomInputWidget;
import '../../i10n/localization_intl.dart' show AppLocalizations;
import '../../widgets/flex_button.dart' show CustomFlexButton;
import '../../widgets/language_dialog.dart' show LanguageDialog;
import '../../store/locale.dart' show ChangeLocaleAction;
import '../../widgets/password_input.dart' show CustomPasswordInput;
import '../../store/login.dart' show LoginAction;
import '../../utils/storage.dart' show LocalStorage;
import '../../utils/config.dart' show Config;

class LoginPage extends StatefulWidget {
  static const String path = 'login';

  // @override
  // State<LoginPage> createState() {
  //   return _LoginPageState();
  // }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _userName = '';
  String? _password = '';

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  _LoginPageState() : super();

  @override
  void initState() {
    super.initState();
    _initParams();
  }

  _initParams() async {
    // _userName = await
    _userName = await LocalStorage.get(Config.USERNAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  void _onLogin(Store<AppState> store) {
    if (_userName == null || _password == null) {
      return;
    }
    store.dispatch(LoginAction(context, _userName!, _password!));
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            body: Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                //防止overFlow的现象
                child: SafeArea(
                  //同时弹出键盘不遮挡
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: CustomColors.cardWhite,
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 30.0,
                          top: 40.0,
                          right: 30.0,
                          bottom: 0.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image(
                              image: AssetImage(CustomICons.DEFAULT_USER_ICON),
                              width: 90.0,
                              height: 90.0,
                            ),
                            Padding(padding: EdgeInsets.all(10.0)),
                            CustomInputWidget(
                              autofocus: true,
                              hintText: AppLocalizations.of(context)
                                  .loginUsernameHint,
                              iconData: CustomICons.LOGIN_USER,
                              onChanged: (String value) {
                                _userName = value;
                              },
                              controller: userController,
                            ),
                            Padding(padding: EdgeInsets.all(10.0)),
                            CustomPasswordInput(
                              hintText: AppLocalizations.of(context)
                                  .loginUsernameHint,
                              iconData: CustomICons.LOGIN_PW,
                              onChanged: (String value) {
                                _password = value;
                              },
                              obscureText: true, // 是否掩码
                              controller: pwController,
                            ),
                            Padding(padding: EdgeInsets.all(30.0)),
                            CustomFlexButton(
                              text: AppLocalizations.of(context).login,
                              color: Theme.of(context).primaryColor,
                              textColor: CustomColors.textWhite,
                              onPress: () {
                                _onLogin(store);
                              },
                            ),
                            Padding(padding: EdgeInsets.all(15.0)),
                            InkWell(
                              onTap: () {
                                _showLanguageDialog(context, store);
                              },
                              child: Text(
                                AppLocalizations.of(context).languageToggle,
                                style:
                                    TextStyle(color: CustomColors.subTextColor),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(15.0)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<LanguageDialog?> _showLanguageDialog(
    BuildContext context, Store<AppState> store) {
  Function _onLanguageToggle(Locale locale) {
    
    return () {
      store.dispatch(ChangeLocaleAction(locale: locale));
      LocalStorage.set(Config.LOCALE, locale.toString());
      Navigator.pop(context);
    };
  }

  return showDialog<LanguageDialog>(
    context: context,
    builder: (BuildContext context) {
      return LanguageDialog(onPressed: _onLanguageToggle);
    },
  );
}
