import 'package:dio/dio.dart';

class Config{
  BaseOptions options;

  Config() {
    this.options = new BaseOptions(
      /// Http method.
      // String method;

      /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: "https://api.s.suv666.com/",

      /// Http请求头.
      // Map<String, dynamic> headers;

      /// 连接服务器超时时间，单位是毫秒.
      // int connectTimeout;
      /// 2.x中为接收数据的最长时限.
      // int receiveTimeout;

      /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则,
      /// 将会和baseUrl拼接出完整的的url.
      // String path = "";

      /// 请求的Content-Type，默认值是[ContentType.JSON].
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `ContentType.parse("application/x-www-form-urlencoded")`,  这样[Dio]
      /// 就会自动编码请求体.
      // ContentType contentType;

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      // ResponseType responseType;

      /// `validateStatus` 决定http响应状态码是否被dio视为请求成功， 返回`validateStatus`
      ///  返回`true` , 请求结果就会按成功处理，否则会按失败处理.
      // ValidateStatus validateStatus;

      /// 用户自定义字段，可以在 [Interceptor]、[Transformer] 和 [Response] 中取到.
      // Map<String, dynamic> extra;

      /// 公共query参数
      // Map<String, dynamic /*String|Iterable<String>*/ > queryParameters;
    );
  }
}

final Config config = new Config();