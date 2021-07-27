import 'package:redux/redux.dart' show combineReducers, TypedReducer;
import '../model/user.dart' show User;

final userReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateLoaded),
]);

User _updateLoaded(User? user, action) {
  return action.userInfo;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction {}
