import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/screen/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: MyColors.acikMatSiyah,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "BORSA CEPTE",
            style: TextStyle(
              fontFamily: "SourceSansPro",
              fontSize: 35,
              wordSpacing: 1,
              fontWeight: FontWeight.w900,
              color: MyColors.matSari,
            ),
          ),
          Image.asset(
            "assets/moneylogo2.png",
            width: 330,
            fit: BoxFit.fitWidth,
          ),
        ],
      )),
    );
  }
}
