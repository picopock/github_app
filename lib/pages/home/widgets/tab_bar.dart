import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  static const int BOTTOM_TAB = 1;
  static const int TOP_TAB = 2;

  final int? type;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? tabItems;
  final List<Widget>? tabViews;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final String? title;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomBar;
  final TarWidgetControl? tarWidgetControl;
  final ValueChanged<int>? onPageChanged;

  CustomTabBar({
    Key? key,
    this.type,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.bottomBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset,
    this.tarWidgetControl,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState(
        type!,
        tabViews!,
        indicatorColor!,
        drawer!,
        floatingActionButton!,
        tarWidgetControl!,
        onPageChanged!,
      );
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  final int? _type;
  final List<Widget>? _tabViews;
  final Color? _indicatorColor;
  final Widget? _drawer;
  final Widget? _floatingActionButton;
  final TarWidgetControl? _tarWidgetControl;
  final PageController _pageController = PageController();
  final ValueChanged<int>? _onPageChanged;

  _CustomTabBarState(
    this._type,
    this._tabViews,
    this._indicatorColor,
    this._drawer,
    this._floatingActionButton,
    this._tarWidgetControl,
    this._onPageChanged,
  ) : super();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.tabItems!.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this._type == CustomTabBar.TOP_TAB) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
              controller: _tabController,
              tabs: widget.tabItems!,
              indicatorColor: _indicatorColor,
              onTap: (index) {
                _onPageChanged?.call(index);
                _pageController
                    .jumpTo(MediaQuery.of(context).size.width * index);
              }),
        ),
        body: PageView(
          controller: _pageController,
          children: _tabViews!,
          onPageChanged: (int index) {
            _tabController.animateTo(index);
            _onPageChanged?.call(index);
          },
        ),
        bottomNavigationBar: widget.bottomBar,
        floatingActionButton: SafeArea(
          child: _floatingActionButton ?? Container(),
        ),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        persistentFooterButtons:
            _tarWidgetControl == null ? null : _tarWidgetControl!.footerButton,
      );
    }

    return Scaffold(
      drawer: _drawer,
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        controller: _pageController,
        children: _tabViews!,
        onPageChanged: (int index) {
          _tabController.animateTo(index);
          _onPageChanged?.call(index);
        },
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: TabBar(
            controller: _tabController,
            tabs: widget.tabItems!,
            indicatorColor: _indicatorColor,
            onTap: (int index) {
              _onPageChanged?.call(index);
              _pageController.jumpTo(MediaQuery.of(context).size.width * index);
            },
          ),
        ),
      ),
    );
  }
}

class TarWidgetControl {
  List<Widget> footerButton = [];
}
