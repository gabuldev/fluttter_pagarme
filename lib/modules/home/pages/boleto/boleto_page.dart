import 'package:flutter/material.dart';
import 'package:flutter_pagarme_create/modules/home/pages/boleto/boleto_controller.dart';

class BoletoPage extends StatefulWidget {
  BoletoPage({Key? key}) : super(key: key);

  @override
  _BoletoPageState createState() => _BoletoPageState();
}

class _BoletoPageState extends State<BoletoPage> {
  final controller = BoletoController();
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
                  decoration: InputDecoration(labelText: "Valor"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    controller.onChange(amount: int.parse(value));
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nome Completo"),
                  onChanged: (value) {
                    controller.onChange(name: value);
                  },
                ),
                TextFormField(
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
                          controller.generateBoleto();
                        },
                        child: Text("Gerar boleto!"));
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
