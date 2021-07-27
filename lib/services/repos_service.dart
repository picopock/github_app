import 'package:dio/dio.dart' show Options;

import './address.dart' show Address;
import './http/http.dart' show http;
import '../utils/config.dart' show Config;
import '../model/trending_repo_model.dart' show TrendingRepoModel;
import './data_result.dart' show DataResult;
import './http/result_data.dart' show ResultData;
import './http/code.dart' show Code;
import '../utils/trend_util.dart' show TrendingUtil;

class GitHubTrending {
  fetchTrending(url) async {
    var res = await http.request(url,
        options: new Options(contentType: "text/plain; charset=utf-8"));
    if (res.result && res.data != null) {
      return new ResultData(
          TrendingUtil.htmlToRepo(res.data), true, Code.SUCCESS);
    } else {
      return res;
    }
  }
}

class ReposService {
  static getTrend(
      {since = 'daily', languageType, pageIndex = 0, pageSize = 20}) async {
    final String url = Address.trendingApi(since, languageType);
    final result = await http.request(url,
        headers: {'api-token': Config.API_TOKEN}, isNoTip: true);
    if (result.data is List) {
      List<TrendingRepoModel> list = [];
      if (result.data?.length == 0) {
        return new DataResult(null, false);
      }

      for (int i = 0; i < result.data.length; i++) {
        TrendingRepoModel model = TrendingRepoModel.fromJson(result.data[i]);
        list.add(model);
      }
      return new DataResult(list, true);
    } else {
      final String url = Address.trending(since, languageType);
      final res = await new GitHubTrending().fetchTrending(url);
      if (res.result && res.data.length > 0) {
        List<TrendingRepoModel> list = [];
        if (res.data == null || res.data.length == 0) {
          return new DataResult(null, false);
        }
        for (int i = 0; i < res.data.length; i++) {
          TrendingRepoModel model = res.data[i];
          list.add(model);
        }
        return new DataResult(list, true);
      }
      return new DataResult(null, false);
    }
  }
}
