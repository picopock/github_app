import 'dart:convert' show utf8, base64, json;
import 'package:dio/dio.dart' show Options;

import '../utils/storage.dart' show LocalStorage;
import '../utils/config.dart' show Config;
import '../services/http/http.dart' show http;
import './address.dart' show Address;
import './http/config.dart' show HttpConfig;
import '../model/user.dart' show User;
import './data_result.dart' show DataResult;
import 'package:redux_epics/redux_epics.dart' show EpicStore;
import '../store/app.dart' show AppState;

class UserService {
  static login(
      String username, String password, EpicStore<AppState> store) async {
    String type = username + ':' + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);

    if (Config.DEBUG) {
      print('base64Str：' + base64Str);
    }

    await LocalStorage.set(Config.USERNAME_KEY, username);
    await LocalStorage.set(Config.USER_BASIC_CODE, base64Str);

    Map<String, dynamic> requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": HttpConfig.CLIENT_ID,
      "client_secret": HttpConfig.CLIENT_SECRET
    };

    http.clearAuthorization();

    var res = await http.request(
      Address.getAuthorization(),
      data: json.encode(requestParams),
      options: new Options(method: 'post'),
    );

    return new DataResult(null, res.result);
  }

  static getAccessTokenByOAuthCode(String code) async {
    final Map<String, dynamic> data = {
      "code": code,
      "client_id": HttpConfig.CLIENT_ID,
      "client_secret": HttpConfig.CLIENT_SECRET
    };

    final res = await http.request(
      Address.getAccessTokenByOAuthCode(),
      data: data,
      options: new Options(method: 'POST'),
    );

    if (res.result) {
      print('get access token: ${res.data}');
      final _token = "${res.data['token_type']} ${res.data['access_token']}";
      await LocalStorage.set(Config.TOKEN_KEY, _token);
    }
    return res.result;
  }

  static getUserInfo([String? username]) async {
    final String url = username == null
        ? Address.getMyUserInfo()
        : Address.getUserInfo(username);
    final res = await http.request(url);

    if (res.result) {
      String starredCount = '---';
      if (res.data['type'] != 'Organization') {
        final staredCountRes = await getUserStaredCount(res.data['login']);
        if (staredCountRes.result) {
          starredCount = staredCountRes.data;
        }
      }
      User user = User.fromJson(res.data);
      user.starred = starredCount;
      if (username == null) {
        LocalStorage.set(Config.USER_INFO, json.encode(user.toJson()));
      }
      return new DataResult(user, true);
    } else {
      return new DataResult(res.data, false);
    }
  }

  /// 如果存在 access_token 从本地加载用户数据
  static initUserInfo() async {
    final String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token != null && token.length > 0) {
      final res = await getUserInfoLocal();
      return res;
    }
  }

  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getUserStaredCount(username) async {
    final String url = Address.userStar(username) + '&per_page=1';
    final res = await http.request(url);
    if (res.result && res.headers != null) {
      try {
        List<String> link = res.headers['link'];
        if (link.length > 0) {
          int indexStart = link[0].lastIndexOf('page=') + 5;
          int indexEnd = link[0].lastIndexOf('>');
          if (indexStart >= 0 && indexEnd >= 0) {
            String count = link[0].substring(indexStart, indexEnd);
            return new DataResult(count, true);
          }
        }
      } catch (error) {
        print(error);
      }
    }
    return new DataResult(null, false);
  }
}
