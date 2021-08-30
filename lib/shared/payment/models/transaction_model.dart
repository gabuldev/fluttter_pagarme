import 'package:flutter_pagarme_create/shared/payment/models/customer_model.dart';

abstract class TransactionModel {
  final int amount;
  final String paymentMethod;
  final CustomerModel customer;

  TransactionModel({
    required this.amount,
    required this.paymentMethod,
    required this.customer,
  });
  Map<String, dynamic> toMap();
}

class CreditTransactionModel extends TransactionModel {
  final String cardId;
  CreditTransactionModel(
      {required this.cardId,
      required int amount,
      required CustomerModel customer})
      : super(
          paymentMethod: "credit_card",
          amount: amount,
          customer: customer,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      "customer": customer.toMap(),
      "amount": amount,
      "card_id": cardId,
      "payment_method": paymentMethod
    };
  }
}

class BoletoTransactionModel extends TransactionModel {
  BoletoTransactionModel({required int amount, required CustomerModel customer})
      : super(
          paymentMethod: "boleto",
          amount: amount,
          customer: customer,
        );
  @override
  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "payment_method": paymentMethod,
      "customer": customer.toMap()
    };
  }
}
