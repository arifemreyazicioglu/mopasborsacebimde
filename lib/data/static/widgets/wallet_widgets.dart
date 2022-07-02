import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/models/exchangelist.dart';

class WalletList {
  walletList(
    List<Exchange> liveExchanges,
    List<Exchange> oldExchanges,
    BuildContext context,
  ) {
    setExchangeColor(liveExchanges, oldExchanges);

    setDailyChangePercentColor(liveExchanges, oldExchanges);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListTile(
            tileColor: MyColors.acikMatSiyah,
            title: Text(
              "Piyasalar",
              style: TextStyle(color: MyColors.matSari, fontSize: 20),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                children: [
                  Text(
                    "Varlıklarım",
                    style: TextStyle(color: MyColors.matSari, fontSize: 20),
                  ),
                  Text(
                    "Toplam : 120000 ₺",
                    style: TextStyle(color: MyColors.matSari, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: liveExchanges.length,
            itemBuilder: (BuildContext context, int index) {
              double topPad = 2;
              if (index == 0) topPad = 4;
              return slidableExchangeCard(
                context,
                liveExchanges,
                oldExchanges,
                index,
                topPad,
              );
            },
          ),
        )
      ],
    );
  }

  Widget slidableExchangeCard(
    BuildContext context,
    List<Exchange> liveExchanges,
    List<Exchange> oldExchanges,
    int index,
    double topPad,
  ) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: MyColors.kapaliMatSiyah,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2, top: topPad),
          child: Card(
            margin: EdgeInsets.only(top: 0),
            child: ListTile(
              tileColor: MyColors.acikMatSiyah,
              title: getTitle(liveExchanges, index),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitle(List<Exchange> liveExchanges, int index) {
    var name = liveExchanges[index].name;
    var siteName = liveExchanges[index].siteName;
    var price = liveExchanges[index].price;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              siteName + " ",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "SourceSansPro",
                  fontWeight: FontWeight.bold,
                  color: liveExchanges[index].color),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "SourceSansPro",
                fontWeight: FontWeight.bold,
                color: liveExchanges[index].color,
              ),
            ),
          ],
        ),
        Text(
          price.toString(),
          style: TextStyle(
            fontSize: 16,
            fontFamily: "SourceSansPro",
            fontWeight: FontWeight.bold,
            color: liveExchanges[index].color,
          ),
        ),
      ],
    );
  }

  void setExchangeColor(
      List<Exchange> liveExchanges, List<Exchange> oldExchanges) {
    for (int i = 0; i < liveExchanges.length; i++) {
      try {
        if (oldExchanges[i].price == liveExchanges[i].price) {
          liveExchanges[i].color = MyColors.matSari;
        } else if (oldExchanges[i].price > liveExchanges[i].price) {
          liveExchanges[i].color = Colors.redAccent;
        } else {
          liveExchanges[i].color = Colors.greenAccent;
        }
      } catch (error) {
        print(error);
      }
    }
  }

  void setDailyChangePercentColor(
      List<Exchange> liveExchanges, List<Exchange> oldExchanges) {
    for (int i = 0; i < liveExchanges.length; i++) {
      try {
        if (double.parse(liveExchanges[i].dailyChangePercent) > 0.0) {
          liveExchanges[i].dailyChangePercentColor = Colors.greenAccent;
        } else if (double.parse(liveExchanges[i].dailyChangePercent) < 0.0) {
          liveExchanges[i].dailyChangePercentColor = Colors.redAccent;
        }
      } catch (error) {
        print(error);
      }
    }
  }
}

/* String route = ModalRoute.of(context).settings.name;

  // ignore: deprecated_member_use
  List<PiyasalarScrollView> _piyasalarScrollView = [
    PiyasalarScrollView(id: 1, name: "BTCTurk"),
    PiyasalarScrollView(id: 2, name: "Binance"),
    PiyasalarScrollView(id: 3, name: "Foreks"),
    PiyasalarScrollView(id: 4, name: "Paribu"),
    PiyasalarScrollView(id: 5, name: "BTCTRY"),
    PiyasalarScrollView(id: 6, name: "BTCUSDT"),
    PiyasalarScrollView(id: 7, name: "USD"),
    PiyasalarScrollView(id: 8, name: "EURO"),
    PiyasalarScrollView(id: 9, name: "STERLIN"),
  ];
  final _items = _piyasalarScrollView
      .map((selectedScrollView) => MultiSelectItem<PiyasalarScrollView>(
          selectedScrollView, selectedScrollView.name))
      .toList();

  // ignore: unused_local_variable
  List<PiyasalarScrollView> _selectedBTCTurk = [];
  // ignore: unused_local_variable
  List<PiyasalarScrollView> _selectedScrollViews3 = [];

  // ignore: unused_local_variable
  List<PiyasalarScrollView> _selectedScrollViews4 = [];
  // ignore: unused_local_variable
  final _multiSelectKey = GlobalKey<FormFieldState>();*/

  // ignore: deprecated_member_use