import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Escolha uma forma de pagamento:"),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/credit-card");
              },
              child: Text("Cartão de Crédito"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/boleto");
              },
              child: Text("Boleto"),
            )
          ],
        ),
      ),
    );
  }
}
