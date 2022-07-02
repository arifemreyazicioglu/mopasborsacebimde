import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/global/select_underbar_color.dart';

portfoyUnderAppBar(context, route) {
  Color portfoyColor = Colors.white;
  Color alarmColor = Colors.white;
  Color usdtProfitColor = Colors.white;

  return underPortfoyBarRow(
    context,
    route,
    portfoyColor,
    alarmColor,
    usdtProfitColor,
  );
}

underPortfoyBarRow(context, route, Color portfoyColor, Color alarmColor,
    Color usdtProfitColor) {
  return Row(children: <Widget>[
    Expanded(
      flex: 1,
      child: Ink(
        height: 60,
        color: getSelectPortfoyColor(context, route, portfoyColor),
        child: InkWell(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Portföy",
              style: TextStyle(
                color: MyColors.matSari,
                fontFamily: "SourceSansPro",
                fontSize: 16,
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, "/portfoy");
          },
        ),
      ),
    ),
    Expanded(
      flex: 1,
      child: Ink(
        height: 60,
        color: getSelectAlarmColor(context, route, alarmColor),
        child: InkWell(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Alarmlarım",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontFamily: "SourceSansPro",
                  fontSize: 16,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                "/alarmlar",
              );
            }),
      ),
    ),
    Expanded(
      flex: 1,
      child: Ink(
        height: 60,
        color: getSelectUsdtProfitColor(context, route, usdtProfitColor),
        child: InkWell(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "USDT Profit",
              style: TextStyle(
                color: MyColors.matSari,
                fontFamily: "SourceSansPro",
                fontSize: 16,
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(
              context,
              "/usdtprofit",
            );
          },
        ),
      ),
    ),
  ]);
}

getSelectPortfoyColor(context, route, portfoyColor) {
  portfoyColor = MyColors.kapaliMatSiyah;
  if (selectUnderBarInk(context, route) == 0)
    portfoyColor = MyColors.acikMatSiyah;

  return portfoyColor;
}

getSelectAlarmColor(context, route, alarmlarColor) {
  alarmlarColor = MyColors.kapaliMatSiyah;
  if (selectUnderBarInk(context, route) == 1)
    alarmlarColor = MyColors.acikMatSiyah;

  return alarmlarColor;
}

getSelectUsdtProfitColor(context, route, usdtProfitColor) {
  usdtProfitColor = MyColors.kapaliMatSiyah;
  if (selectUnderBarInk(context, route) == 2)
    usdtProfitColor = MyColors.acikMatSiyah;

  return usdtProfitColor;
}
