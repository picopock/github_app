import 'dart:convert' show utf8, base64, json;
import 'package:redux/redux.dart' show Store;
import 'package:dio/dio.dart' show Options;

import '../utils/storage.dart' show LocalStorage;
import '../utils/config.dart' show Config;
import '../services/http/http.dart' show http;
import './address.dart' show Address;
import './http/config.dart' show HttpConfig;
import '../store/user.dart' show UpdateUserAction;
import '../model/user.dart' show User;
import './data_result.dart' show DataResult;

class UserService {
  static login(username, password, store) async {
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

    if (res.result) {
      LocalStorage.set(Config.PW_KEY, password);
      getUserInfo().then((resultData) {
        store.dispatch(new UpdateUserAction(resultData.data));
        if (Config.DEBUG) {
          print('user result ${resultData.result.toString()}');
          print(res.data.toString());
        }
      });
    }
    return new DataResult(null, res.result);
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

  static initUserInfo(Store store) async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();
    if (res != null && res.result && token != null) {
      store.dispatch(UpdateUserAction(res.data));
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
        if (link.length>0) {
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
