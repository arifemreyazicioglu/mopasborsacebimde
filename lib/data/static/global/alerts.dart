import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mopasborsacebimde/data/service/add_remove_firebase_array.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/models/exchangelist.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

getErrorAlert(BuildContext context, String mesaj) {
  return Alert(
    closeIcon: Text(""),
    context: context,
    type: AlertType.error,
    style: AlertStyle(
        backgroundColor: Color.fromRGBO(40, 40, 40, .0),
        titleStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        descStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Color.fromRGBO(237, 217, 76, 25.0)),
        ),
        animationType: AnimationType.shrink),
    title: mesaj,
    buttons: [
      DialogButton(
        radius: BorderRadius.zero,
        color: MyColors.matSari,
        padding: EdgeInsets.all(5),
        child: Text(
          "Tamam",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 150,
      )
    ],
  ).show();
}

getAppbarAlert(BuildContext context, String mesaj) {
  return Alert(
    closeIcon: Text(""),
    context: context,
    type: AlertType.info,
    style: AlertStyle(
        backgroundColor: Color.fromRGBO(40, 40, 40, .0),
        titleStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        descStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Color.fromRGBO(237, 217, 76, 25.0)),
        ),
        animationType: AnimationType.shrink),
    title: mesaj,
    buttons: [
      DialogButton(
        radius: BorderRadius.zero,
        color: MyColors.matSari,
        padding: EdgeInsets.all(5),
        child: Text(
          "Hayır",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 150,
      ),
      DialogButton(
        radius: BorderRadius.zero,
        color: MyColors.matSari,
        padding: EdgeInsets.all(5),
        child: Text(
          "Evet",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/login");
        },
        width: 150,
      )
    ],
  ).show();
}

alarmAddAlert(BuildContext context, TextEditingController _textFieldController,
    List<Exchange> liveExchanges, int index, String title) {
  String sembol = "₺";
  if (liveExchanges[index].name.contains("USDT")) sembol = "\$";
  Alert(
    closeIcon: Text(""),
    context: context,
    type: AlertType.info,
    style: AlertStyle(
        backgroundColor: Color.fromRGBO(40, 40, 40, .0),
        titleStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        descStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Color.fromRGBO(237, 217, 76, 25.0)),
        ),
        animationType: AnimationType.shrink),
    title: title,
    desc: _textFieldController.text + sembol + " değeri için alarm kuruldu!",
    buttons: [
      DialogButton(
        radius: BorderRadius.zero,
        color: Color.fromRGBO(237, 217, 76, 25.0),
        padding: EdgeInsets.all(5),
        child: Text(
          "Tamam",
          style: TextStyle(
              color: MyColors.kapaliMatSiyah,
              fontSize: 20,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800),
        ),
        onPressed: () async {
          FirebaseArray().addFirebaseArrayAlarms(
            context,
            liveExchanges,
            _textFieldController,
            index,
            sembol,
          );
          Navigator.pop(context);
        },
        width: 150,
      )
    ],
  ).show();
}

alarmDeleteAlert(BuildContext context, int index, List alarms) {
  Alert(
    closeIcon: Text(""),
    context: context,
    type: AlertType.info,
    style: AlertStyle(
        backgroundColor: Color.fromRGBO(40, 40, 40, .0),
        titleStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        descStyle: TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Color.fromRGBO(237, 217, 76, 25.0)),
        ),
        animationType: AnimationType.shrink),
    desc: alarms[index].toString() + " alarmı silindi!",
    buttons: [
      DialogButton(
        radius: BorderRadius.zero,
        color: Color.fromRGBO(237, 217, 76, 25.0),
        padding: EdgeInsets.all(5),
        child: Text(
          "Tamam",
          style: TextStyle(
              color: MyColors.kapaliMatSiyah,
              fontSize: 20,
              fontFamily: "SourceSansPro",
              fontWeight: FontWeight.w800),
        ),
        onPressed: () async {
          FirebaseArray().deleteFirebaseArrayAlarms(context, alarms, index);
          Navigator.pop(context);
        },
        width: 150,
      )
    ],
  ).show();
}

alarmForm(
    BuildContext context,
    String title,
    int index,
    GlobalKey<FormState> formKey,
    TextEditingController _textFieldController,
    List<Exchange> liveExchanges) {
  return Form(
    key: formKey,
    child: AlertDialog(
      backgroundColor: MyColors.acikMatSiyah,
      title: Text(
        title,
        style: TextStyle(color: MyColors.matSari),
      ),
      content: TextFormField(
        inputFormatters: [
          // ignore: deprecated_member_use
          FilteringTextInputFormatter(RegExp(r"^\d{0,6}\.?\d{0,4}"), allow: true),
        ],
        keyboardType: TextInputType.number,
        cursorColor: MyColors.matSari,
        style: TextStyle(color: MyColors.matSari),
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Değer girin: ',
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: MyColors.matSari,
          ),
          hoverColor: MyColors.matSari,
          errorStyle: TextStyle(
            color: MyColors.matSari,
            fontSize: 15,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.matSari,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.matSari,
            ),
          ),
        ),
        controller: _textFieldController,
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new FlatButton(
            child: new Text(
              'Alarm Ekle',
              style: TextStyle(color: MyColors.matSari),
            ),
            onPressed: () {
              if (_textFieldController.text != "") {
                _showSnackBarForAlarm(
                    liveExchanges, context, title, index, _textFieldController);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'Lütfen bir değer giriniz!',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              }
            }),
      ],
    ),
  );
}

_showSnackBarForAlarm(List<Exchange> liveExchanges, BuildContext context,
    String title, int index, TextEditingController _textFieldController) async {
  await alarmAddAlert(
      context, _textFieldController, liveExchanges, index, title);
}
