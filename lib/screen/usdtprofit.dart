import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopasborsacebimde/data/api/usdtprofitapi.dart';
import 'package:mopasborsacebimde/data/static/global/globalfunctions.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/appbar.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/bttm_nvg.dart';
import 'package:mopasborsacebimde/data/static/widgets/usdtprofitwidgets.dart';
import 'package:mopasborsacebimde/models/usdtprofit.dart';

class UsdtProfitScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UsdtProfitScreenState();
  }
}

class UsdtProfitScreenState extends State {
  Future<List<UsdtProfit>>? usdtProfitList;
  final textFieldController = TextEditingController();
  Color usdtProfitColor = MyColors.matSari;

  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    textFieldController.text = "";
    setUpTimedFetch();
  }

  // ignore: unused_element

  setUpTimedFetch() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        try {
          if (usdtProfitColor == MyColors.matSari)
            usdtProfitColor = Colors.white;
          else
            usdtProfitColor = MyColors.matSari;
        } catch (error) {
          print(error);
        }

        usdtProfitList = getUsdtProfitListFromWebApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? route = ModalRoute.of(context)!.settings.name;
    return Scaffold(
      appBar: getPortfoyAppBar(context,route!),
      body: FutureBuilder(
        future: usdtProfitList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return usdtProfitListFunc(snapshot.data, context,
                textFieldController, usdtProfitColor);
          } else if (snapshot.hasError)
            return Text('${snapshot.error}');
          else
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.matSari,
              ),
            );
        },
      ),
      backgroundColor: MyColors.kapaliMatSiyah,
      bottomNavigationBar: BorsaAppBttmNvg.getBtmNvgBar(
        context,
        GlobalFunctions.getCurrentIndex(runtimeType.toString()),
      ),
    );
  }
}
