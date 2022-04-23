class FinanceService {
 static double dolar(Map<dynamic, dynamic>? json) {
    return json!["results"]["currencies"]["USD"]["buy"] ?? 0;
  }

  static double euro(Map<dynamic, dynamic>? json) {
    return json!["results"]["currencies"]["EUR"]["buy"] ?? 0;
  }
}
