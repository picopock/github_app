import 'package:event_bus/event_bus.dart' show EventBus;

import '../pages/dynamic/dynamic_page.dart' show DynamicPage;
import '../pages/trend/trend_page.dart' show TrendPage;
import '../pages/mine/mine_page.dart' show MinePage;

EventBus eventBus = new EventBus();

class HomePageRefreshEvent {
  final String pageName;
  final bool isDynamicPage;
  final bool isTrendPage;
  final bool isMinePage;

  static const Map<int, String> _pageNameMap = {
    0: DynamicPage.path,
    1: TrendPage.path,
    2: MinePage.path,
  };

  HomePageRefreshEvent(int _tabIndex)
      : pageName = _pageNameMap[_tabIndex]!,
        isDynamicPage = _tabIndex == 0,
        isTrendPage = _tabIndex == 1,
        isMinePage = _tabIndex == 2;
}
