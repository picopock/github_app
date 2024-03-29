import 'dart:async' show Future;
import 'dart:collection' show HashMap;
import 'package:dio/dio.dart'
    show
        Dio,
        Options,
        DioError,
        Response,
        DioErrorType,
        RequestOptions,
        Headers;

import '../http/interceptors/token_interceptor.dart' show TokenInterceptors;
import '../http/interceptors/header_interceptor.dart' show HeaderInterceptors;
import '../http/interceptors/log_interceptor.dart' show LogsInterceptors;
import '../http/interceptors/error_interceptor.dart' show ErrorInterceptors;
import './result_data.dart' show ResultData;
import './code.dart' show Code;

class HTTP {
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FROM = 'application/x-www-form-urlencoded';

  static HTTP? inst;

  static HTTP? getInstance() {
    if (inst != null) {
      return inst;
    }
    inst = new HTTP();
    return inst;
  }

  Dio _dio = new Dio();

  TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HTTP() {
    _dio.interceptors.add(new HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogsInterceptors());
    _dio.interceptors.add(new ErrorInterceptors(/**_dio*/));
  }

  Future<ResultData> request(
    String path, {
    data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Options? options,
    isNoTip = false,
  }) async {
    Map<String, dynamic> _headers = new HashMap();
    if (headers != null) {
      _headers.addAll(headers);
    }

    if (options != null) {
      options.headers = _headers;
    } else {
      options = new Options(method: 'get');
      options.headers = _headers;
    }

    try {
      // Future<Response<T>> request<T>(
      //   String path, {
      //   data,
      //   Map<String, dynamic> queryParameters,
      //   CancelToken cancelToken,
      //   Options options,
      //   ProgressCallback onSendProgress,
      //   ProgressCallback onReceiveProgress,
      // });
      Response response = await _dio.request(path,
          data: data, queryParameters: params, options: options);
      RequestOptions _options = response.requestOptions;
      ResultData value;
      final header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains('text')) {
        value = new ResultData(response.data, true, Code.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = new ResultData(
          response.data,
          true,
          Code.SUCCESS,
          headers: response.headers,
        );
      } else {
        print('${_options.path}\n ${response.toString()}');
        value = new ResultData(
          response.data,
          false,
          response.statusCode!,
          headers: response.headers,
        );
      }
      return value;
    } on DioError catch (error) {
      return resultError(error, isNoTip);
    }
  }

  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }

  resultError(DioError error, bool isNoTip) {
    Response? errorResponse;
    if (error.response != null) {
      errorResponse = error.response;
    } else {
      errorResponse =
          new Response(statusCode: 666, requestOptions: error.requestOptions);
    }

    if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      errorResponse?.statusCode = Code.NETWORK_TIMEOUT;
    }

    return new ResultData(
      Code.errorHandleFunction(
        errorResponse?.statusCode,
        error.message,
        isNoTip,
      ),
      false,
      errorResponse!.statusCode!,
    );
  }
}

final HTTP http = HTTP.getInstance()!;
