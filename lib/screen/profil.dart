import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class ProfilScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilScreenState();
  }
}

class ProfilScreenState extends State {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kapaliMatSiyah,
      appBar: AppBar(
        backgroundColor: MyColors.acikMatSiyah,
        title: Text(
          "Profil",
          style: TextStyle(
            color: MyColors.matSari,
            fontFamily: "SourceSansPro",
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(context, "/wallet"),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: MyColors.matSari,
            size: 20,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            getUserInfo(context),
            getChangePassword(context),
          ],
        ),
      ),
    );
  }
}

getChangePassword(BuildContext context) {
  // ignore: deprecated_member_use
  return TextButton(
    onPressed: () {
      Navigator.pushReplacementNamed(context, "/changePassword");
    },
    child: Text(
      "Şifre Değiştirme",
      style: TextStyle(
        color: MyColors.matSari,
        fontSize: 15,
        fontFamily: "SourceSansPro",
      ),
    ),
  );
}

getUserInfo(BuildContext context) {
  final FirebaseAuth auth = FirebaseAuth.instance;

  return Container(
    padding: EdgeInsets.only(top: 10),
    margin: EdgeInsets.symmetric(horizontal: 10),
    color: MyColors.acikMatSiyah,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.2,
    child: Column(
      children: [
        Text(
          "Kullanıcı Bilgileri",
          style: TextStyle(
            color: MyColors.matSari,
            fontSize: 20,
            fontFamily: "SourceSansPro",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 5),
          child: Row(
            children: [
              Text(
                "Email : ",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontSize: 18,
                  fontFamily: "SourceSansPro",
                ),
              ),
              Text(
                "${auth.currentUser!.email}",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontSize: 15,
                  fontFamily: "SourceSansPro",
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 5),
          child: Row(
            children: [
              Text(
                "Kayıt Tarihi : ",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontSize: 18,
                  fontFamily: "SourceSansPro",
                ),
              ),
              Text(
                "${auth.currentUser!.metadata.creationTime.toString().split(" ")[0]}",
                style: TextStyle(
                  color: MyColors.matSari,
                  fontSize: 15,
                  fontFamily: "SourceSansPro",
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
