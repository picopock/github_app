import 'package:rxdart/rxdart.dart';

import './redux_epics/redux_epics.dart' show EpicClass, EpicStore;
import '../app.dart' show AppState;
import '../login.dart' show LoginAction, LoginSuccessAction;
import '../../services/user_service.dart' show UserService;
import '../../widgets/loading_dialog.dart' show Loading;

class LoginEpic implements EpicClass<AppState> {
  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<LoginAction>().switchMap((action) async* {
      Loading.show(action.context);
      var result = await UserService.login(
          action.username.trim(), action.password.trim(), store);
      Loading.hide(action.context);
      yield LoginSuccessAction(
        action.context,
        (result != null && result.result),
      );
    });
  }
}
