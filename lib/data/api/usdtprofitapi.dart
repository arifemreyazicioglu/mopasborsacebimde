import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mopasborsacebimde/models/usdtprofit.dart';


Future<List<UsdtProfit>> getUsdtProfitListFromWebApi() async {
  var apiUrl = Uri(
    scheme: "http",
    host: "192.168.1.17",
    port: 2929,
    path: "/GetUsdtProfit",
  );

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    // ignore: deprecated_member_use
    List<UsdtProfit> usdtProfitList = <UsdtProfit>[];

    try {
      json.forEach((key, value) {
        if (key == "usdtProfitList")
          for (var usdtProfit in value)
            usdtProfitList.add(UsdtProfit.fromJson(usdtProfit));
      });
    } catch (error) {
      print(error);
    }

    return usdtProfitList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
