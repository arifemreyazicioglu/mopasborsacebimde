import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/models/exchangelist.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirebaseArray {
  deleteFirebaseExchangeListArray(
      List<Exchange> liveExchanges, int index) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var docId = auth.currentUser!.uid;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Person").doc(docId);

    docRef.update({
      'exchangeList': FieldValue.arrayRemove(
          [liveExchanges[index].siteName + " " + liveExchanges[index].name])
    });
  }

  addFirebaseExchangeListArray(
      BuildContext context, List<Exchange> liveExchanges, int index) async {
    String mesaj = "Portföye Eklendi!";
    final FirebaseAuth auth = FirebaseAuth.instance;
    var docId = auth.currentUser!.uid;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Person").doc(docId);

    DocumentSnapshot? doc = await docRef.get();
    List tags = doc['exchangeList'];
    if (tags.contains(
            liveExchanges[index].siteName + " " + liveExchanges[index].name) ==
        true) {
      mesaj = "Bu piyasa portföye ekli!";
    } else {
      docRef.update({
        'exchangeList': FieldValue.arrayUnion(
            [liveExchanges[index].siteName + " " + liveExchanges[index].name])
      });
    }
    _showSnackBarForExchangeListAdd(
      liveExchanges,
      context,
      liveExchanges[index].name,
      mesaj,
      liveExchanges[index].siteName,
      index,
      1,
    );
  }

  addFirebaseArrayAlarms(
      BuildContext context,
      List<Exchange> liveExchanges,
      TextEditingController _textFieldController,
      int index,
      String sembol) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var docId = auth.currentUser!.uid;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Person").doc(docId);

    docRef.update({
      'alarms': FieldValue.arrayUnion([
        liveExchanges[index].siteName +
            " " +
            liveExchanges[index].name +
            " " +
            _textFieldController.text +
            sembol
      ])
    });
    Navigator.pop(context);
  }

  deleteFirebaseArrayAlarms(BuildContext context, List alarms, int index) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var docId = auth.currentUser!.uid;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Person").doc(docId);

    docRef.update({
      'alarms': FieldValue.arrayRemove([alarms[index].toString()])
    });
  }

  _showSnackBarForExchangeListAdd(
    List<Exchange> liveExchanges,
    BuildContext context,
    String title,
    String dsc,
    String subtitle,
    int index,
    int flag,
  ) async {
    await Alert(
      closeIcon: Text(""),
      context: context,
      type: AlertType.info,
      style: AlertStyle(
          backgroundColor: Color.fromRGBO(40, 40, 40, .0),
          titleStyle:
              TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
          descStyle:
              TextStyle(color: Colors.white, fontFamily: "SourceSansPro"),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Color.fromRGBO(237, 217, 76, 25.0)),
          ),
          animationType: AnimationType.shrink),
      title: title + "(" + subtitle + ")",
      desc: dsc,
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
          onPressed: () {
            Navigator.pop(context);
          },
          width: 150,
        )
      ],
    ).show();
  }
}
