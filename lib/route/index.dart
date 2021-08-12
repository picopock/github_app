import 'package:flutter/material.dart';

import '../pages/home/home_page.dart' show HomePage;
import '../pages/login/login_page.dart' show LoginPage;
import '../pages/login/login_webview.dart' show LoginWebview;
import '../pages/mine/mine_page.dart' show MinePage;

class Router {
  // 替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  // 切换无参页面
  static pushNamed(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static goHome(BuildContext context) {
    return Navigator.pushReplacementNamed(context, HomePage.path);
  }

  static goLogin(BuildContext context) {
    return Navigator.pushReplacementNamed(context, LoginPage.path);
  }

  static goMinePage(BuildContext context) {
    return Navigator.pushNamed(context, MinePage.path);
  }

  static goTrendUserPage(BuildContext context) {
    // 哟问题
    return Navigator.pushNamed(context, 'TrendUserPage');
  }

  static goPerson(BuildContext context, dynamic hhh) {
    //
    return Navigator.pushNamed(context, 'TrendUserPage');
  }

  static goReposDetail(BuildContext context, dynamic hhh, dynamic hhhh) {
    // 详情
    return Navigator.pushNamed(context, 'TrendUserPage');
  }

  static Future<String?> goLoginWebview(
      BuildContext context, String url, String title) {
    // 跳转到 oauth 授权登录页面
    return Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LoginWebview(url, title),
      ),
    );
  }
}
