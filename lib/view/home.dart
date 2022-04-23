import 'package:conversor_moedas2/repository/finance_repository.dart';
import 'package:conversor_moedas2/service/finance_service.dart';
import 'package:conversor_moedas2/utils/media_query_screen.dart';
import 'package:conversor_moedas2/view/widgets/conversor_text_field.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _realController = TextEditingController();
  final TextEditingController _dolarController = TextEditingController();
  final TextEditingController _euroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Conversor de Moedas',
          style: TextStyle(
              fontSize: MediaQueryScreen.height(context, 3),
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: FinanceRepository().getFinanceValue(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Carregando dados",
                  style: TextStyle(
                      fontSize: MediaQueryScreen.height(context, 2),
                      color: Colors.amber),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQueryScreen.height(context, 2)),
                    child: Container(
                      height: MediaQueryScreen.height(context, 20),
                      width: MediaQueryScreen.width(context, 20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/gold.png"),
                        ),
                      ),
                    ),
                  ),
                  ConversorTextFiel(
                    controller: _realController,
                    label: "Real",
                    prefix: "R\$",
                    onChanged:(value)=> _realChanged(value, snapshot.data!),
                    onTap: _clearAll,
                  ),
                  const Divider(),
                  ConversorTextFiel(
                    controller: _dolarController,
                    label: "Dólar",
                    prefix: "US\$",
                    onChanged: (value)=> _dolarChanged(value, snapshot.data!),
                    onTap: _clearAll,
                  ),
                  const Divider(),
                  ConversorTextFiel(
                    controller: _euroController,
                    label: "Euro",
                    prefix: "€",
                    onChanged: (value)=> _euroChanged(value, snapshot.data!),
                    onTap: _clearAll,
                  ),
                  const Divider(),
                  Container(
                    width: MediaQueryScreen.width(context, 10),
                    height: MediaQueryScreen.height(context, 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: TextButton(
                      onPressed: _clearAll,
                      child: Text(
                        "Limpar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQueryScreen.height(context, 3),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
  }

  void _realChanged(String real, Map<dynamic, dynamic> json) {
    if (real.isEmpty) {
      _clearAll();
    } else {
      _dolarController.text =
          (double.parse(real) / FinanceService.dolar(json)).toStringAsFixed(2);
      _euroController.text =
          (double.parse(real) / FinanceService.euro(json)).toStringAsFixed(2);
    }
  }

  void _dolarChanged(String dolar, Map<dynamic, dynamic> json) {
    if (dolar.isEmpty) {
      _clearAll();
    } else {
      _realController.text =
          (double.parse(dolar) * FinanceService.dolar(json)).toStringAsFixed(2);
      _euroController.text = (double.parse(dolar) *
              FinanceService.dolar(json) /
              FinanceService.euro(json))
          .toStringAsFixed(2);
    }
  }

  void _euroChanged(String euro, Map<dynamic, dynamic> json) {
    if (euro.isEmpty) {
      _clearAll();
    } else {
      _realController.text =
          (double.parse(euro) * FinanceService.euro(json)).toStringAsFixed(2);
      _dolarController.text = (double.parse(euro) *
              FinanceService.euro(json) /
              FinanceService.dolar(json))
          .toStringAsFixed(2);
    }
  }
}
