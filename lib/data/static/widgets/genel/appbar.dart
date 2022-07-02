import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/appbar_leading.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/portfoy_underappbar.dart';

getPortfoyAppBar(BuildContext context, String route) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    // ignore: deprecated_member_use
    brightness: Brightness.dark,
    shadowColor: Colors.black,
    backgroundColor: MyColors.acikMatSiyah,
    title: Text(
      'Borsa Cepte',
      style: TextStyle(
        fontFamily: "SourceSansPro",
        fontWeight: FontWeight.bold,
        color: MyColors.matSari,
      ),
    ),
    leading: getLeading(context),
    bottom: PreferredSize(
        child: portfoyUnderAppBar(context, route),
        preferredSize: Size.fromHeight(60.0)),
  );
}

getAppBar(BuildContext context, String route) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    // ignore: deprecated_member_use
    brightness: Brightness.dark,
    shadowColor: Colors.black,
    backgroundColor: MyColors.acikMatSiyah,
    title: Text(
      'Borsa Cepte',
      style: TextStyle(
        fontFamily: "SourceSansPro",
        fontWeight: FontWeight.bold,
        color: MyColors.matSari,
      ),
    ),
    leading: getLeading(context),
  );
}
