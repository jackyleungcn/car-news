import 'package:dio/dio.dart';
import '../createData.dart';
import '../code.dart';

class RequestInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    options.data.add("cname", "WEB_YCYH");
    options.data.add("c_ver", 321001);
    options.data.add("ctype", 5);

    return options;
  }
}
