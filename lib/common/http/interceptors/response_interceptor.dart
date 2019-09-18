import 'package:dio/dio.dart';
import '../createData.dart';
import '../code.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response res) async {
    RequestOptions option = res.request;
    try {
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      print(e.toString() + option.baseUrl + option.path);
      return new CreateData(e, Code.NETWORK_ERROR);
    }
  }
}
