import 'package:flutter/material.dart' hide Router;
import 'package:flutter_redux/flutter_redux.dart'
    show StoreProvider, StoreBuilder;
import 'package:redux/redux.dart' show Store;
import 'package:flare_flutter/flare_actor.dart' show FlareActor;

import '../store/app.dart' show AppState;
import '../route/index.dart' show Router;
import '../services/user_service.dart' show UserService;
import '../../store/user.dart' show UpdateUserAction;

class WelcomePage extends StatefulWidget {
  static const String path = 'welcome';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hasInited = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hasInited) {
      return;
    }
    hasInited = true;
    Store<AppState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      // 获取本地用户信息，如果有跳转到 home，如果没有跳转到登录页面
      UserService.initUserInfo().then((res) {
        if (res != null && res?.result) {
          store.dispatch(UpdateUserAction(res.data));
          Router.goHome(context);
        } else {
          Router.goLogin(context);
        }
        return true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (BuildContext context, Store<AppState> store) {
        double size = 200;
        return Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage('static/images/welcome.png'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: size,
                  height: size,
                  child: FlareActor(
                    'static/file/flare_flutter_logo_.flr',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                    animation: 'Placeholder',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
