import 'package:dio/dio.dart'
    show Interceptor, RequestOptions, RequestInterceptorHandler;
import '../../../utils/storage.dart' show LocalStorage;
import '../../../utils/config.dart' show Config;

class TokenInterceptors extends Interceptor {
  String? _token;

  getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String? basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        // 提示输入账号密码
      } else {
        // 通过 basic 去获取 token, 获取到设置，返回 token
        return 'Basic $basic';
      }
    } else {
      this._token = token;
      return token;
    }
  }

  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers['Authorization'] = _token;
    }
    return handler.next(options);
  }
}
