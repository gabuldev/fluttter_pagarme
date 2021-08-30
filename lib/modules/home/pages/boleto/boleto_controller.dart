import 'package:flutter/material.dart';
import 'package:flutter_pagarme_create/shared/payment/models/customer_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/document_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/transaction_model.dart';
import 'package:flutter_pagarme_create/shared/payment/payment_controller.dart';

class BoletoController extends ChangeNotifier {
  final payment = PaymentController();
  int amount = 0;
  String name = "";
  String cpf = "";

  bool enableButton = false;

  void onChange({int? amount, String? name, String? cpf}) {
    this.amount = amount ?? this.amount;
    this.name = name ?? this.name;
    this.cpf = cpf ?? this.cpf;
    validator();
  }

  void validator() {
    if (amount > 0 && name.isNotEmpty && cpf.isNotEmpty) {
      enableButton = true;
      notifyListeners();
    }
  }

  void generateBoleto() {
    final transaction = BoletoTransactionModel(
        amount: amount,
        customer: CustomerModel(
            email: "mopheus@nabucodonozor.com",
            phoneNumbers: ["+5511999998888"],
            externalId: "1",
            type: "individual",
            country: "br",
            name: name,
            documents: [DocumentModel(type: "cpf", number: cpf)]));
    payment.create(transaction);
  }
}
