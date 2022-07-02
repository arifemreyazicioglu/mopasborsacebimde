import 'package:flutter/cupertino.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class UsdtProfit {
  UsdtProfit({
    required this.name,
    required this.price,
    required this.parite,
    required this.profit,
  });

  String name;
  double price;
  double parite;
  double profit;
  Color usdtColor = MyColors.matSari;

  factory UsdtProfit.fromJson(Map<String, dynamic> json) => UsdtProfit(
        name: json["name"],
        price: json["price"].toDouble(),
        parite: json["parite"].toDouble(),
        profit: json["profit"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "parite": parite,
        "profit": profit,
      };
}
