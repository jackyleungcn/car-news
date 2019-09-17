import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class RequestInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    {
      int cVer = 321001;
      String cName = "WEB_YCYH";
      String stringifyData = options.data.toString();
      String timestamp =
          (DateTime.now().millisecondsSinceEpoch.toInt() ~/ 1000).toString();
      String sign = this.generateMd5(cName +
          stringifyData +
          timestamp.substring(timestamp.length - 4) +
          cName);

      options.data = new FormData.from({
        "data": stringifyData,
        "cname": cName,
        "c_ver": cVer,
        "ctype": 5,
        "ext": {
          "sign": sign,
          "timestamp": timestamp,
        }.toString(),
      });
    }

    return options;
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
