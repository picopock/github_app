import 'package:redux/redux.dart' show combineReducers, TypedReducer;
import '../model/user.dart' show User;

final userReducer = combineReducers<User?>([
  TypedReducer<User?, UpdateUserAction>(_updateUserInfo),
]);

User _updateUserInfo(User? user, action) {
  return action.userInfo;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);

  @override
  toString() {
    return "UpdateUserAction: \n userInfo: " + this.userInfo.toString();
  }
}

class FetchUserAction {}
