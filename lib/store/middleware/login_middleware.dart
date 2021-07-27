import 'package:redux/redux.dart' show Store, MiddlewareClass, NextDispatcher;
import '../app.dart' show AppState;
import '../../route/index.dart' show Router;
import '../login.dart' show LogoutAction;
import '../../utils/storage.dart' show LocalStorage;
import '../../utils/config.dart' show Config;
import '../../services/http/http.dart' show http;

class LoginMiddleware implements MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LogoutAction) {
      http.clearAuthorization();
      LocalStorage.remove(Config.USER_INFO);
      Router.goLogin(action.context);
    }

    next(action);
  }
}
