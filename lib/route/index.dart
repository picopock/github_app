import 'package:flutter/material.dart';

import '../pages/home/home_page.dart' show HomePage;
import '../pages/login/login_page.dart' show LoginPage;
import '../pages/mine/mine_page.dart' show MinePage;

class Router {
  // 替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // 切换无参页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.path);
  }

  static goLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.path);
  }

  static goMinePage(BuildContext context) {
    Navigator.pushNamed(context, MinePage.path);
  }

  static goTrendUserPage(BuildContext context) {
    // 哟问题
    Navigator.pushNamed(context, 'TrendUserPage');
  }

  static goPerson(BuildContext context, dynamic hhh) {
    // 哟问题
    Navigator.pushNamed(context, 'TrendUserPage');
  }

  static goReposDetail(BuildContext context, dynamic hhh, dynamic hhhh) {
    // 哟问题
    Navigator.pushNamed(context, 'TrendUserPage');
  }
}
