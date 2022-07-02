import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/alerts.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

getLeading(BuildContext context) {
  return Theme(
    data: Theme.of(context).copyWith(
      textTheme: TextTheme().apply(bodyColor: MyColors.acikMatSiyah),
      dividerColor: MyColors.matSari,
      iconTheme: IconThemeData(color: MyColors.matSari),
    ),
    child: PopupMenuButton<int>(
      color: MyColors.acikMatSiyah,
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: MyColors.matSari,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                "Profil",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontFamily: "SourceSansPro",
                ),
              )
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: MyColors.matSari,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                "Çıkış",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontFamily: "SourceSansPro",
                ),
              )
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.message,
                color: MyColors.matSari,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                "Message",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontFamily: "SourceSansPro",
                ),
              )
            ],
          ),
        ),
      ],
      onSelected: (item) => selectedItem(context, item),
    ),
  );
}

void selectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.pushReplacementNamed(context, "/profil");
      break;

    case 1:
      print("User Logged out");
      getAppbarAlert(context, "Giriş ekranına gitmek istiyor musunuz?");
      break;

    case 2:
      Navigator.pushReplacementNamed(context, "/message");
  }
}
