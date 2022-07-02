import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/api/exchangelistapi.dart';
import 'package:mopasborsacebimde/data/static/global/globalfunctions.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/appbar.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/bttm_nvg.dart';

import 'package:mopasborsacebimde/data/static/widgets/wallet_widgets.dart';
import 'package:mopasborsacebimde/models/exchangelist.dart';

class WalletScreen extends StatefulWidget {
  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  Future<List<Exchange>>? exchanges;
  // ignore: deprecated_member_use
  late List<Exchange> oldExchanges = <Exchange>[];

  void initState() {
    super.initState();
    setUpTimedFetch();
  }

  setUpTimedFetch() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        try {
          exchanges?.then((value) => oldExchanges = value);
        } catch (error) {
          print(error);
        }
        exchanges = getExchangeListFromWebApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? route = ModalRoute.of(context)!.settings.name;
    return Scaffold(
      appBar: getAppBar(context, route!),
      body: FutureBuilder(
        future: exchanges,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return WalletList().walletList(
              snapshot.data,
              oldExchanges,
              context,
            );
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
