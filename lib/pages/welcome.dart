import 'package:flutter/material.dart' hide Router;
import 'package:flutter_redux/flutter_redux.dart'
    show StoreProvider, StoreBuilder;
import 'package:redux/redux.dart' show Store;
import 'package:flare_flutter/flare_actor.dart' show FlareActor;

import '../store/app.dart' show AppState;
import '../route/index.dart' show Router;
import '../services/user_service.dart' show UserService;

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
      UserService.initUserInfo(store).then((res) {
        if (res != null && res.result) {
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
