import 'package:dio/dio.dart' show Interceptor, RequestOptions, Response, RequestInterceptorHandler, ResponseInterceptorHandler;
import '../../../utils/storage.dart' show LocalStorage;
import '../../../utils/config.dart' show Config;

class TokenInterceptors extends Interceptor {
  String? _token;

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers['Authorization'] = _token;
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      var responseJSON = response.data;
      if (response.statusCode == 201 && responseJSON['token'] != null) {
        _token = 'token ' + responseJSON['token'];
        await LocalStorage.set(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return handler.next(response);
  }

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
}
