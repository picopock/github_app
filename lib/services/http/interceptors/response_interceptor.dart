import 'package:dio/dio.dart'
    show InterceptorsWrapper, Response, RequestOptions, Headers, ResponseInterceptorHandler;
import '../code.dart' show Code;
import '../result_data.dart' show ResultData;

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    RequestOptions options = response.requestOptions;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains('text')) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = new ResultData(
          response.data,
          true,
          Code.SUCCESS,
          headers: response.headers,
        );
      }
    } catch (error) {
      print('${options.path}\n ${error.toString()}');
      value = new ResultData(
        response.data,
        false,
        response.statusCode!,
        headers: response.headers,
      );
    }
    return handler.next(value);
  }
}
