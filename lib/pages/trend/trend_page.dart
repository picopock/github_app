import 'package:flutter/material.dart' hide Router;
import 'package:flutter/rendering.dart' show FloatingHeaderSnapConfiguration;
import 'package:flutter_redux/flutter_redux.dart' show StoreBuilder;
import 'package:redux/redux.dart' show Store;
import 'package:event_bus/event_bus.dart' show EventBus;

import '../../store/app.dart' show AppState;
import '../../i10n/localization_intl.dart' show AppLocalizations;
import '../../style/index.dart' show CustomColors, Constant;
import '../../bloc/trend_bloc.dart' show TrendBloc;
import '../../model/trending_repo_model.dart' show TrendingRepoModel;
import '../../route/index.dart' show Router;
import './sliver_header_delegate.dart' show SliverHeaderDelegate;
import '../../widgets/card_item.dart' show CustomCardItem;
import './widgets/repos_item.dart' show ReposViewModel, ReposItem;
import '../../widgets/empty.dart' show Empty;
import '../../utils/event_bus.dart' show eventBus, HomePageRefreshEvent;

/// bloc (rxdart + streamBuilder)

class TrendPage extends StatefulWidget {
  static const String path = 'trend';
  TrendPage({Key? key}) : super(key: key);

  @override
  _TrendPageState createState() {
    return _TrendPageState();
  }
}

class _TrendPageState extends State<TrendPage>
    with
        AutomaticKeepAliveClientMixin<TrendPage>,
        SingleTickerProviderStateMixin {
  final TrendBloc trendBloc = new TrendBloc();
  final ScrollController scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TrendTypeModel? selectTime;
  TrendTypeModel? selectType;

  final EventBus _eventBus = eventBus;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // 进入页面加载数据(回调方法在Widget渲染完成时触发)
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      selectTime = trendTime(context)[0];
      selectType = trendType(context)[0];

      refreshData();
    });

    // 监听页面resumed,刷新页面
    _eventBus.on<HomePageRefreshEvent>().listen((HomePageRefreshEvent event) {
      if (event.isTrendPage) {
        refreshData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return StoreBuilder<AppState>(
      builder: (BuildContext context, Store<AppState> store) {
        return Scaffold(
          backgroundColor: CustomColors.mainBackgroundColor,
          // StreamBuilder from 'material'
          body: StreamBuilder<List<TrendingRepoModel>>(
            stream: trendBloc.stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<TrendingRepoModel>> snapshot,
            ) {
              /// 嵌套滚动
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshData,
                notificationPredicate:
                    nestedScrollViewScrollNotificationPredicate,
                child: NestedScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return _renderHeaderSliver(
                      context,
                      innerBoxIsScrolled,
                      store,
                    );
                  },
                  body: snapshot.data == null || snapshot.data?.length == 0
                      ? Empty()
                      : new ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return _renderItem(snapshot.data?[index]);
                          },
                          itemCount: snapshot.data?.length,
                        ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Router.goTrendUserPage(context);
            },
            child: Icon(
              Icons.person,
              size: 30.0,
            ),
          ),
        );
      },
    );
  }

  Widget _renderItem(data) {
    ReposViewModel reposViewModal = ReposViewModel.fromTrendMap(data);

    return ReposItem(
      reposViewModal,
      onPressed: () {
        Router.goReposDetail(
            context, reposViewModal.ownerName, reposViewModal.repositoryName);
      },
    );
  }

  // 嵌套滚动头部
  List<Widget> _renderHeaderSliver(
      BuildContext context, bool innerBoxIsScroll, Store<AppState> store) {
    return <Widget>[
      SliverPersistentHeader(
        pinned: true, // 是否 stick
        // Configuration for the sliver's layout.
        delegate: SliverHeaderDelegate(
            maxHeight: 65.0,
            minHeight: 65.0,
            changeSize: true,
            snapConfig: FloatingHeaderSnapConfiguration(
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 10),
            ),
            builder: (BuildContext context, double shrinkOffset,
                bool overlapsContent) {
              // 根据数值计算偏差
              var lr = 10 - shrinkOffset / 65 * 10;
              var radius = Radius.circular(4 - shrinkOffset / 65 * 4);
              return SizedBox.expand(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: lr, bottom: 15, left: lr, right: lr),
                  child: _renderHeader(store, radius),
                ),
              );
            }),
      ),
    ];
  }

  // 绘制头部可选item
  Widget _renderHeader(Store<AppState> store, Radius radius) {
    if (selectTime == null && selectType == null) {
      return Container();
    }
    return CustomCardItem(
      color: store.state.themeData.primaryColor,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Row(
          children: <Widget>[
            _renderHeaderPopItem(
              selectTime!.name,
              trendTime(context),
              (TrendTypeModel result) {
                if (trendBloc.isLoading) {
                  return;
                }
                scrollController
                    .animateTo(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceInOut)
                    .then((_) {
                  setState(() {
                    selectTime = result;
                  });
                  refreshData();
                });
              },
            ),
            Container(
              height: 20.0,
              width: 0.5,
              color: CustomColors.white,
            ),
            _renderHeaderPopItem(
              selectType!.name,
              trendType(context),
              (TrendTypeModel result) {
                if (trendBloc.isLoading) {
                  return;
                }
                scrollController
                    .animateTo(
                  0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.bounceInOut,
                )
                    .then((_) {
                  setState(() {
                    selectType = result;
                  });
                  refreshData();
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _renderHeaderPopItem(String data, List<TrendTypeModel> list,
      PopupMenuItemSelected<TrendTypeModel> onSelected) {
    return Expanded(
      child: PopupMenuButton<TrendTypeModel>(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(data, style: Constant.middleTextWhite),
        ),
        onSelected: onSelected,
        offset: const Offset(0.0, 60.0),
        itemBuilder: (BuildContext context) {
          return _renderHeaderPopItemChild(list);
        },
      ),
    );
  }

  List<PopupMenuEntry<TrendTypeModel>> _renderHeaderPopItemChild(
      List<TrendTypeModel> data) {
    List<PopupMenuEntry<TrendTypeModel>> list =
        <PopupMenuEntry<TrendTypeModel>>[];
    for (TrendTypeModel item in data) {
      list.add(PopupMenuItem<TrendTypeModel>(
        value: item,
        child: Text(
          item.name,
          style: Constant.middleTextWhite,
        ),
      ));
    }
    return list;
  }

  void refreshData() {
    _refreshIndicatorKey.currentState!.show();
  }

  Future<dynamic> _refreshData() {
    return trendBloc.initData(selectTime, selectType);
  }
}

class TrendTypeModel {
  final String name;
  final String? value;
  TrendTypeModel(this.name, this.value);
}

List<TrendTypeModel> trendType(BuildContext context) {
  return [
    TrendTypeModel(AppLocalizations.of(context).trendAll, null),
    TrendTypeModel("Java", "Java"),
    TrendTypeModel("Kotlin", "Kotlin"),
    TrendTypeModel("Dart", "Dart"),
    TrendTypeModel("Objective-C", "Objective-C"),
    TrendTypeModel("Swift", "Swift"),
    TrendTypeModel("JavaScript", "JavaScript"),
    TrendTypeModel("PHP", "PHP"),
    TrendTypeModel("Go", "Go"),
    TrendTypeModel("C++", "C++"),
    TrendTypeModel("C", "C"),
    TrendTypeModel("HTML", "HTML"),
    TrendTypeModel("CSS", "CSS"),
    TrendTypeModel("Python", "Python"),
    TrendTypeModel("C#", "c%23"),
  ];
}

List<TrendTypeModel> trendTime(BuildContext context) {
  return [
    TrendTypeModel(AppLocalizations.of(context).daily, 'daily'),
    TrendTypeModel(AppLocalizations.of(context).weekly, 'weekly'),
    TrendTypeModel(AppLocalizations.of(context).monthly, 'monthly'),
  ];
}

bool nestedScrollViewScrollNotificationPredicate(
    ScrollNotification notification) {
  return notification.depth == 1;
}
