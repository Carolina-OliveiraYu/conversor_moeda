import 'dart:convert';

import 'package:http/http.dart' as http;

class FinanceRepository {
  final String _request =
      "https://api.hgbrasil.com/finance?format=json&key48d90269";

  Future<Map> getFinanceValue() async {
    http.Response response = await http.get(Uri.parse(_request));
    return json.decode(response.body);
  }
}
