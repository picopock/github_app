import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart' show StoreProvider;
import 'package:redux/redux.dart' show Store;
import 'package:github_app/i10n/localization_intl.dart';
import 'package:scoped_model/scoped_model.dart'
    show ScopedModelDescendant, ScopedModel;
import 'package:event_bus/event_bus.dart' show EventBus;

import '../../scope_model/dynamic_model.dart' show DynamicModel;
import './widgets/event_item.dart' show EventItem;
import '../../store/app.dart' show AppState;
import '../../widgets/spin_kit_rotating_circle.dart' show SpinKitRotatingCircle;
import '../../model/event.dart' show Event;
import '../../utils/index.dart' show Utils;
import '../../utils/event_util.dart' show EventUtils;
import '../../widgets/empty.dart' show Empty;
import '../../utils/event_bus.dart' show eventBus, HomePageRefreshEvent;

class DynamicPage extends StatefulWidget {
  static const String path = 'dynamic';
  @override
  _DynamicPageState createState() {
    return _DynamicPageState();
  }
}

class _DynamicPageState extends State<DynamicPage>
    with AutomaticKeepAliveClientMixin<DynamicPage> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final EventBus _eventBus = eventBus;

  @override
  void initState() {
    super.initState();

    // 上啦刷新
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });

    // 进入页面加载数据(回调方法在Widget渲染完成时触发)
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      refreshData();
    });

    // 监听页面resumed,刷新页面
    _eventBus.on<HomePageRefreshEvent>().listen((HomePageRefreshEvent event) {
      if (event.isDynamicPage) {
        refreshData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 第一种获取 model 的方式
    return ScopedModelDescendant<DynamicModel>(
        builder: (BuildContext context, Widget? child, DynamicModel model) {
      return Scaffold(
        body: Container(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshData,
            child: ListView.builder(
              // 确保滚动视图始终可以滚动
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _renderItem(model, index);
              },
              itemCount: _getCount(context: context),
              controller: _scrollController,
            ),
          ),
        ),
      );
    });
  }

  _getCount({BuildContext? context, DynamicModel? model}) {
    // 第二种获取 model 的方式
    final DynamicModel dynamicModel =
        model ?? ScopedModel.of<DynamicModel>(context!, rebuildOnChange: true);
    // 第三种获取 model 的方式，如果重写了of方法，直接用DynamicModel.of(context)
    // final DynamicModel dynamicModel = DynamicModel.of(context);
    final int count = dynamicModel.dataList.length;
    return count == 0 ? 1 : count + 1;
  }

  _renderItem(DynamicModel model, int index) {
    final int count = model.dataList.length;

    if (count == 0) {
      return Empty();
    } else if (index == count) {
      return _buildLoadMoreIndicator(model);
    } else {
      final data = model.dataList[index];
      return _buildItem(data);
    }
  }

  _buildLoadMoreIndicator(DynamicModel model) {
    final Widget content = model.isLoadingMore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
              Container(
                width: 5.0,
              ),
              Text(
                AppLocalizations.of(context).loadingMore,
                style: TextStyle(
                  color: Color(0xFF121917),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        : Container();
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(child: content),
    );
  }

  // _buildEmpty() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height / 4 * 3,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         FlatButton(
  //           onPressed: () {},
  //           child: Image(
  //             image: AssetImage(CustomICons.DEFAULT_USER_ICON),
  //             width: 70.0,
  //             height: 70.0,
  //           ),
  //         ),
  //         Container(
  //           child: Text(
  //             AppLocalizations.of(context).noData,
  //             style: Constant.normalText,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  _buildItem(data) {
    final EventViewModel eventModel = EventViewModel.fromEventMap(data);
    return EventItem(
      eventModel,
      onPressed: () {},
    );
  }

  DynamicModel get dynamicModel =>
      DynamicModel.of(context, rebuildOnChange: false);

  Store<AppState> get store =>
      StoreProvider.of<AppState>(context, listen: false);

  void refreshData() {
    _refreshIndicatorKey.currentState!.show();
  }

  Future<void> _refreshData() async {
    final String? username = store.state.userInfo?.login;
    await dynamicModel.initData(username!);
  }

  Future<void> _loadMore() async {
    final String? username = store.state.userInfo?.login;
    await dynamicModel.loadMore(username!);
  }
}

class EventViewModel {
  late String actionUser;
  late String actionUserPic;
  late String actionDes;
  late String actionTime;
  late String actionTarget;

  EventViewModel.fromEventMap(Event event) {
    actionTime = Utils.getTimeStr(event.createdAt);
    actionUser = event.actor.login;
    actionUserPic = event.actor.avatarUrl;
    var other = EventUtils.getActionAndDes(event);
    actionDes = other["des"];
    actionTarget = other["actionStr"];
  }
}
