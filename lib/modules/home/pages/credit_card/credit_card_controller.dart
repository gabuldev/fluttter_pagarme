import 'package:flutter/material.dart';
import 'package:flutter_pagarme_create/shared/payment/models/credit_card_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/customer_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/document_model.dart';
import 'package:flutter_pagarme_create/shared/payment/models/transaction_model.dart';
import 'package:flutter_pagarme_create/shared/payment/payment_controller.dart';

class CreditCardController extends ChangeNotifier {
  final payment = PaymentController();
  var creditCard = CreditCardModel();
  String cpf = "";

  bool enableButton = false;

  void onChange(
      {String? number,
      String? name,
      String? expiration,
      String? cvv,
      String? cpf}) {
    creditCard = creditCard.copyWith(
        number: number, name: name, expiration: expiration, cvv: cvv);
    this.cpf = cpf ?? this.cpf;
    validator();
  }

  void validator() {
    if (creditCard.cvv.isNotEmpty &&
        creditCard.expiration.isNotEmpty &&
        creditCard.name.isNotEmpty &&
        creditCard.number.isNotEmpty &&
        cpf.isNotEmpty) {
      enableButton = true;
      notifyListeners();
    }
  }

  void generateTransaction() async {
    final response = await payment.generateCardHash(creditCard);
    creditCard = response;
    final cardId = await payment.createCardId(creditCard);
    final responseTransaction = await payment.create(
      CreditTransactionModel(
          cardId: cardId,
          amount: 100,
          customer: CustomerModel(
              email: "mopheus@nabucodonozor.com",
              phoneNumbers: ["+5511999998888"],
              externalId: "1",
              type: "individual",
              country: "br",
              name: creditCard.name,
              documents: [DocumentModel(type: "cpf", number: cpf)])),
    );
  }
}
