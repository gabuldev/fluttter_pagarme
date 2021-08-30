import 'package:dio/dio.dart';

import 'package:flutter_pagarme_create/shared/payment/models/transaction_model.dart';

abstract class PaymentRepository {
  Future<String> create(TransactionModel transaction);
  Future<Map<String, dynamic>> getCardHashKey();
  Future<String> createCreditCard(String hash);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio client;
  PaymentRepositoryImpl({
    required this.client,
  });
  @override
  Future<String> create(TransactionModel transaction) async {
    try {
      final response =
          await client.post("/transactions", data: transaction.toMap());
      print(response.data);
      return response.data['boleto_barcode'];
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map<String, dynamic>> getCardHashKey() async {
    try {
      final response = await client.get("/transactions/card_hash_key");
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> createCreditCard(String hash) async {
    try {
      final response = await client.post("/cards", data: {
        "card_hash": hash,
      });
      return response.data['id'];
    } catch (e) {
      throw e;
    }
  }
}
