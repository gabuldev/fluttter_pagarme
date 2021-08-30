import 'package:dio/dio.dart';

class ApiKeyInterceptor extends InterceptorsWrapper {
  final String apiKey;
  ApiKeyInterceptor({
    required this.apiKey,
  });
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data == null) {
      options..queryParameters = {"api_key": apiKey};
    } else {
      options.data['api_key'] = apiKey;
    }
    handler.next(options);
  }
}
