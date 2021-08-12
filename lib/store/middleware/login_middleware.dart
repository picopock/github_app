import 'package:redux/redux.dart' show Store, MiddlewareClass, NextDispatcher;
import '../app.dart' show AppState;
import '../../route/index.dart' show Router;
import '../login.dart'
    show LogoutAction, OAuthSuccessAction, OAuthLoginSuccessAction;
import '../../utils/storage.dart' show LocalStorage;
import '../../utils/config.dart' show Config;
import '../../services/http/http.dart' show http;
import '../../services/user_service.dart' show UserService;
import '../../store/user.dart' show UpdateUserAction;

class LoginMiddleware implements MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LogoutAction) {
      http.clearAuthorization(); // 清理 auth 中间件 token
      LocalStorage.remove(Config.USER_INFO); // 清除用户信息
      Router.goLogin(action.context);
      return;
    }

    if (action is OAuthSuccessAction) {
      // oauth 授权成功
      http.clearAuthorization();
      // 获取 access token
      final bool? success =
          await UserService.getAccessTokenByOAuthCode(action.code);
      // 获取 access token 成功后，初始化用户信息
      if (success != null && success) {
        /// 登录成功
        store.dispatch(OAuthLoginSuccessAction());

        /// 获取用户信息
        final resData = await UserService.getUserInfo();
        if (Config.DEBUG) {
          print("user result " + resData.result.toString());
          print(resData.data);
        }

        if (resData.result) {
          store.dispatch(UpdateUserAction(resData.data));
          Router.goHome(action.context);
        }
      }
      return;
    }
    next(action);
  }
}
