import 'package:rxdart/rxdart.dart' show PublishSubject;
import '../model/trending_repo_model.dart' show TrendingRepoModel;
import '../services/repos_service.dart' show ReposService;

class TrendBloc {
  bool _requested = false;
  bool _isLoading = false;
  int _pageIndex = 0;
  int _pageSize = 20;

  // 是否正在loading
  bool get isLoading => _isLoading;
  // 是否已经请求过
  bool get requested => _requested;

  // rxdart 实现的 stream
  PublishSubject<List<TrendingRepoModel>> _subject =
      PublishSubject<List<TrendingRepoModel>>();

  Stream<List<TrendingRepoModel>> get stream => _subject.stream;

  Future<void> initData(selectTime, selectType) async {
    _isLoading = true;

    var res = await ReposService.getTrend(
        since: selectTime.value,
        languageType: selectType.value,
        pageIndex: _pageIndex,
        pageSize: _pageSize); // 待填坑
    if (res != null && res.result) {
      _subject.add(res.data);
    }
    _isLoading = false;
    _requested = true;
  }
}
