import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

getLoginAppBar(BuildContext context) {
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
  );
}
