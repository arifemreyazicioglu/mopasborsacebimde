import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mopasborsacebimde/data/service/add_remove_firebase_array.dart';
import 'package:mopasborsacebimde/data/static/global/alerts.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/models/exchangelist.dart';

class PiyasaCardList {
  final _textFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void dispose() {
    _textFieldController.dispose();
  }

  piyasalarCardList(
    List<Exchange> liveExchanges,
    List<Exchange> oldExchanges,
    BuildContext context,
  ) {
    setExchangeColor(liveExchanges, oldExchanges);

    setDailyChangePercentColor(liveExchanges, oldExchanges);

    return Column(
      children: <Widget>[
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
          child: ListTile(     
            tileColor: MyColors.acikMatSiyah,
            leading: getIcon(liveExchanges, oldExchanges, index),
            title: getTitle(liveExchanges, index),
            subtitle: getSubtitle(liveExchanges, index),
            trailing: getPriceAndDailyChangePercent(liveExchanges, index),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Alarm Ekle',
            foregroundColor: Colors.orange,
            color: MyColors.acikMatSiyah,
            icon: Icons.alarm_add,
            onTap: () async {
              _showTextField(
                liveExchanges,
                context,
                liveExchanges[index].name,
                liveExchanges[index].siteName,
                index,
                0,
              );
            }),
        IconSlideAction(
          caption: 'Portföye Ekle',
          foregroundColor: Colors.greenAccent,
          color: MyColors.acikMatSiyah,
          icon: Icons.add,
          onTap: () async {
            FirebaseArray()
                .addFirebaseExchangeListArray(context, liveExchanges, index);
          },
        ),
      ],
    );
  }

  _showTextField(List<Exchange> liveExchanges, BuildContext context,
      String name, String siteName, int index, int i) {
    String title =
        liveExchanges[index].siteName + " " + liveExchanges[index].name;

    return showDialog(
      context: context,
      builder: (context) {
        return alarmForm(context, title, index, formKey, _textFieldController,
            liveExchanges);
      },
    );
  }

  getSubtitle(List<Exchange> liveExchanges, int index) {
    var deneme = liveExchanges[index].siteName;
    return Text(
      deneme,
      style: TextStyle(
        fontSize: 10,
        fontFamily: "SourceSansPro",
        fontWeight: FontWeight.bold,
        color: liveExchanges[index].color,
      ),
    );
  }

  Widget getTitle(List<Exchange> liveExchanges, int index) {
    var deneme = liveExchanges[index].name;
    return Text(
      deneme,
      style: TextStyle(
          fontSize: 18,
          fontFamily: "SourceSansPro",
          fontWeight: FontWeight.bold,
          color: liveExchanges[index].color),
    );
  }

  Widget getPriceAndDailyChangePercent(
      List<Exchange> liveExchanges, int index) {
    String text;
    if (liveExchanges[index].price == 0) {
      text = "-";
      return Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: MyColors.matSari,
          fontFamily: "SourceSansPro",
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            liveExchanges[index].price.toStringAsFixed(4) + "",
            style: TextStyle(
              fontSize: 18,
              color: liveExchanges[index].color,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            " % " + liveExchanges[index].dailyChangePercent.toString(),
            style: TextStyle(
              color: liveExchanges[index].dailyChangePercentColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "SourceSansPro",
            ),
          ),
        ],
      );
    }
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

  getIcon(
      List<Exchange> liveExchanges, List<Exchange> oldExchanges, int index) {
    if (liveExchanges[index].color == Colors.greenAccent) {
      return Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(
            (FontAwesomeIcons.arrowUp),
            color: Colors.greenAccent,
            size: 20,
          ));
    }
    if (liveExchanges[index].color == Colors.redAccent) {
      return Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(
            (FontAwesomeIcons.arrowDown),
            color: Colors.redAccent,
            size: 20,
          ));
    }
    if (liveExchanges[index].color == MyColors.matSari) {
      return Padding(
          padding: EdgeInsets.all(8.0),
          child: FaIcon(
            (FontAwesomeIcons.arrowRight),
            color: MyColors.matSari,
            size: 20,
          ));
    }
  }
}
