import 'package:flutter/material.dart';
import 'package:flutter_pagarme_create/modules/home/pages/credit_card/credit_card_controller.dart';

class CreditCardPage extends StatefulWidget {
  CreditCardPage({Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final controller = CreditCardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insira os dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  initialValue: '4111111111111111',
                  decoration: InputDecoration(labelText: "Número do Cartão"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChange(number: value);
                  },
                ),
                TextFormField(
                  initialValue: 'Gabul DEV',
                  decoration: InputDecoration(labelText: "Nome Completo"),
                  onChanged: (value) {
                    controller.onChange(name: value);
                  },
                ),
                TextFormField(
                  initialValue: "1225",
                  decoration: InputDecoration(labelText: "Data Vencimento"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChange(expiration: value);
                  },
                ),
                TextFormField(
                  initialValue: "123",
                  decoration: InputDecoration(labelText: "CVV"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChange(cvv: value);
                  },
                ),
                TextFormField(
                  initialValue: "13116394032",
                  decoration: InputDecoration(labelText: "CPF"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChange(cpf: value);
                  },
                ),
              ],
            )),
            AnimatedBuilder(
                animation: controller,
                builder: (_, __) {
                  if (controller.enableButton) {
                    return ElevatedButton(
                        onPressed: () {
                          controller.generateTransaction();
                        },
                        child: Text("Gerar HashCartao!"));
                  } else {
                    return Container();
                  }
                }),
            AnimatedBuilder(
                animation: controller.payment,
                builder: (_, __) {
                  if (controller.payment.isLoading) {
                    return CircularProgressIndicator();
                  } else if (controller.payment.hasData) {
                    return Text(
                        "Número do boleto ${controller.payment.response}");
                  } else if (controller.payment.hasError) {
                    return Text(controller.payment.error);
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      ),
    );
  }
}
