import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class Exchange {
  Exchange({
    required this.name,
    required this.siteName,
    required this.price,
    required this.dailyChangePercent,
    //this.asksVolume,
    //this.bidsVolume,
  });

  String name;
  String siteName;
  double price;
  String dailyChangePercent;
  //double asksVolume;
  //double bidsVolume;
  //
  Color color = MyColors.matSari;
  Color dailyChangePercentColor = MyColors.matSari;
  late Icon icon;
   
  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        name: json["name"],
        siteName: json["siteName"],
        price: json["price"].toDouble(),
        dailyChangePercent: json["dailyChangePercent"]
            .toString()
            .replaceAll(",", ".")
            .replaceAll("%", ""),
        // asksVolume: json["asksVolume"].toDouble(),
        // bidsVolume: json["bidsVolume"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "siteName": siteName,
        "price": price,
        "dailyChangePercent": dailyChangePercent,
        //  "asksVolume": asksVolume,
        //  "bidsVolume": bidsVolume,
      };
}
