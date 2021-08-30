import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagarme_create/shared/payment/client/payment_dio.dart';
import 'package:flutter_pagarme_create/shared/payment/models/credit_card_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/transaction_model.dart';
import 'package:flutter_pagarme_create/shared/payment/payment_repository.dart';
import 'package:pointycastle/pointycastle.dart';

class PaymentController extends ChangeNotifier {
  final client = PaymentDio();
  late final repository = PaymentRepositoryImpl(client: client);

  var isLoading = false;
  var error = "";
  var response = "";

  bool get hasError => error.isNotEmpty;
  bool get hasData => response.isNotEmpty;

  Future<void> create(TransactionModel transaction) async {
    try {
      update(isLoading: true);
      final response = await repository.create(transaction);
      this.response = response;
      update(isLoading: false, response: response);
    } catch (e) {
      update(error: e.toString(), isLoading: false);
    }
  }

  void update({bool? isLoading, String? error, String? response}) {
    this.isLoading = isLoading ?? this.isLoading;
    this.error = error ?? this.error;
    this.response = response ?? this.response;
    notifyListeners();
  }

  Future<CreditCardModel> generateCardHash(CreditCardModel creditCard) async {
    final response = await repository.getCardHashKey();
    final publicKey = response['public_key'] as String;
    final id = response['id'] as int;
    final parser = RSAKeyParser();
    final encrypter =
        Encrypter(RSA(publicKey: parser.parse(publicKey) as RSAPublicKey));
    final encrypted = encrypter.encrypt(
      creditCard.queryString(),
    );
    return creditCard.copyWith(
        hash: "${id}_${encrypted.base64}", id: id.toString());
  }

  Future<String> createCardId(CreditCardModel creditCard) async {
    final response = await repository.createCreditCard(creditCard.hash);
    final card_id = response;
    return card_id;
  }
}
