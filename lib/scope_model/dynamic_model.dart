import 'package:flutter/material.dart' show BuildContext;
import 'package:scoped_model/scoped_model.dart' show Model, ScopedModel;

import '../services/event_service.dart' show EventService;

class DynamicModel extends Model {
  static DynamicModel of(
    BuildContext context, {
    bool rebuildOnChange = true,
  }) =>
      ScopedModel.of<DynamicModel>(context, rebuildOnChange: rebuildOnChange);

  List _dataList = [];
  // 是否需要加载更多
  bool _needLoadMore = false;
  bool _isLoadingMore = false;
  int _pageIndex = 1;
  int _pageSize = 20;

  List get dataList => _dataList;

  set dataList(List value) {
    _dataList.clear();
    if (value.isEmpty) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  addList(List value) {
    if (value.isEmpty && value.length > 0) {
      _dataList.addAll(value);
      notifyListeners();
    }
  }

  clearList() {
    dataList = [];
  }

  bool get needLoadMore => _needLoadMore;
  set needLoadMore(bool value) {
    _needLoadMore = value;
    notifyListeners();
  }

  bool get isLoadingMore => _isLoadingMore;
  set isLoadingMore(bool value) {
    _isLoadingMore = value;
    notifyListeners();
  }

  int get pageIndex => _pageIndex;
  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  int get pageSize => _pageSize;
  set pageSize(int val) {
    _pageSize = val;
    notifyListeners();
  }

  // 初始化数据
  Future<dynamic> initData(String username) async {
    pageIndex = 1;
    final res =
        await EventService.getEventReceived(username, _pageIndex, _pageSize);

    needLoadMore = getLoadMoreStatus(res);
    if (res != null && res.data != null) {
      dataList = res.data;
    }
    return res;
  }

  Future<dynamic> loadMore(String username) async {
    if (!needLoadMore) return;
    isLoadingMore = true;
    final res =
        await EventService.getEventReceived(username, pageIndex + 1, pageSize);
    needLoadMore = getLoadMoreStatus(res);
    if (res != null && res.data != null && res.data.length > 0) {
      addList(res.data);
      ++pageIndex;
    }
    isLoadingMore = false;
    return res;
  }

  // 修改加载更多状态
  getLoadMoreStatus(res) {
    return res != null && res.data != null && res.data.length == _pageSize;
  }
}
