import 'package:dio/dio.dart'
    show InterceptorsWrapper, RequestOptions, Response, DioError, RequestInterceptorHandler, ResponseInterceptorHandler, ErrorInterceptorHandler;
import 'package:github_app/utils/config.dart' show Config;

class LogsInterceptors extends InterceptorsWrapper {
  // static List
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (Config.DEBUG) {
      print('request url: ${options.path}');
      print('request header: ${options.headers.toString()}');
      if (options.data != null) {
        print('request params: ${options.data.toString()}');
      }
      print('\r\n');
    }

    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (Config.DEBUG) {
      print('response: ${response.toString()}');
      print('\r\n');
    }

    return handler.next(response);
  }

  @override
  onError(DioError error,ErrorInterceptorHandler handler,) async {
    if (Config.DEBUG) {
      print('request error: ${error.toString()}');
      print('request error info: ${error.response?.toString() ?? ""}');
    }
    return handler.next(error);
  }
}
