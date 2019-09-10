import 'package:dio/dio.dart';
import './config.dart';
import './code.dart';
import './createData.dart';

// interceptors
import './interceptors/request_interceptor.dart';
import './interceptors/response_interceptor.dart';

class HTTP {
  Dio _dio = new Dio(config.options);

  HTTP() {
    _dio.interceptors.add(new RequestInterceptor());
    _dio.interceptors.add(new ResponseInterceptor());
  }

  $post(url, params) async {
    Response res;
    try {
      res = await _dio.post(url, data: params);
    } on DioError catch (e) {
      return resultError(e);
    }

    if(res.data is DioError) {
      return resultError(res.data);
    }
    return res.data;
  }

  resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return new CreateData(
        e.message,
        errorResponse.statusCode);
  }
}

final HTTP $http = new HTTP();