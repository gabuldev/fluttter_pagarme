import 'package:dio/native_imp.dart';
import 'package:flutter_pagarme_create/shared/payment/client/interceptors/api_key_interceptor.dart';

class PaymentDio extends DioForNative {
  PaymentDio() {
    const apiKey = String.fromEnvironment("PAGARME_API_KEY", defaultValue: "");
    if (apiKey.isEmpty) {
      throw "API KEY INVALID!";
    }
    options.baseUrl = "https://api.pagar.me/1";
    interceptors.add(ApiKeyInterceptor(apiKey: apiKey));
  }
}
