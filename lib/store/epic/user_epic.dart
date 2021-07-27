import 'package:rxdart/rxdart.dart';

import './redux_epics/redux_epics.dart' show EpicClass, EpicStore;
import '../app.dart' show AppState;
import '../user.dart' show FetchUserAction, UpdateUserAction;
import '../../services/user_service.dart' show UserService;

class UserEpic implements EpicClass<AppState> {
  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<FetchUserAction>()
        // Don't start  until the 10ms
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 10)))
        .switchMap((action) => _loadUserInfo());
  }

  Stream<dynamic> _loadUserInfo() async* {
    print('*********** userInfoEpic _loadUserInfo ***********');
    var res = await UserService.getUserInfo();
    yield UpdateUserAction(res.data);
  }
}
