import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart' show AndroidIntent;
import 'package:github_app/i10n/localization_intl.dart' show AppLocalizations;
import 'package:event_bus/event_bus.dart' show EventBus;

import './widgets/tab_bar.dart' show CustomTabBar;
import '../../style/index.dart' show CustomColors, CustomICons;
import './widgets/home_drawer.dart' show HomeDrawer;
import '../dynamic/dynamic_page.dart' show DynamicPage;
import '../trend/trend_page.dart' show TrendPage;
import '../mine/mine_page.dart' show MinePage;
import '../../utils/event_bus.dart' show eventBus, HomePageRefreshEvent;

class HomePage extends StatefulWidget {
  static const String path = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final EventBus _eventBus = eventBus;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _eventBus.fire(new HomePageRefreshEvent(_tabIndex));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabs = [
      _renderTab(
        CustomICons.MAIN_DT,
        AppLocalizations.of(context).tabBarItemNameDynamic,
      ),
      _renderTab(
        CustomICons.MAIN_QS,
        AppLocalizations.of(context).tabBarItemNameTrend,
      ),
      _renderTab(
        CustomICons.MAIN_MY,
        AppLocalizations.of(context).tabBarItemNameMine,
      ),
    ];

    List<Widget> _pages = [
      DynamicPage(),
      TrendPage(),
      MinePage(),
    ];

    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: CustomTabBar(
        title: AppLocalizations.of(context).title,
        drawer: HomeDrawer(),
        type: CustomTabBar.BOTTOM_TAB,
        tabItems: _tabs,
        tabViews: _pages,
        backgroundColor: CustomColors.primarySwatch,
        indicatorColor: CustomColors.white,
        onPageChanged: (int index) {
          _tabIndex = index; // 无需刷新
        },
        // title: CustomTitleBar(),
      ),
    );
  }

  // 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    //如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.HOME',
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Icon(icon, size: 16.0), Text(text)],
      ),
    );
  }
}
