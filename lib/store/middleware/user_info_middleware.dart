import 'package:redux/redux.dart' show Store, MiddlewareClass, NextDispatcher;
import '../app.dart' show AppState;
import '../user.dart' show UpdateUserAction;

class UserInfoMiddleware implements MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      print('*********** UserInfoMiddleware ***********');
    }
    next(action);
  }
}
