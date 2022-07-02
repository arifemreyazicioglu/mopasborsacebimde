import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/globalfunctions.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/data/static/widgets/alarmlarscreenwidgets.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/appbar.dart';
import 'package:mopasborsacebimde/data/static/widgets/genel/bttm_nvg.dart';

class AlarmlarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AlarmlarScreenState();
  }
}

class AlarmlarScreenState extends State {
  @override
  Widget build(BuildContext context) {
    String? route = ModalRoute.of(context)!.settings.name;
    return Scaffold(
      appBar: getPortfoyAppBar(context, route!),
      body: getAlarmWidgets(context),
      backgroundColor: MyColors.kapaliMatSiyah,
      bottomNavigationBar: BorsaAppBttmNvg.getBtmNvgBar(
        context,
        GlobalFunctions.getCurrentIndex(runtimeType.toString()),
      ),
    );
  }
}
