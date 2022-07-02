import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mopasborsacebimde/data/static/global/alerts.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

getAlarmWidgets(BuildContext context) {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  var docId = auth.currentUser!.uid;
  CollectionReference moviesRef = _firestore.collection("Person");

  var babaRef = moviesRef.doc(docId);

  return Column(
    children: [
      StreamBuilder<DocumentSnapshot>(
        stream: babaRef.snapshots(), //neyi dinliyoruz
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError)
            return Center(child: Text("Bir hata oluştu"));
          else {
            if (asyncSnapshot.hasData) {
              var alarms = asyncSnapshot.data.data()["alarms"];
              if (alarms.length == 0) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: MediaQuery.of(context).size.height * 0.3),
                    child: Text(
                      "Alarmınız Yok!",
                      style: TextStyle(fontSize: 18, color: MyColors.matSari),
                    ),
                  ),
                );
              } else {
                return Flexible(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Card(
                          margin: EdgeInsets.only(top: 4, right: 3, left: 3),
                          child: ListTile(
                            tileColor: MyColors.acikMatSiyah,
                            title: Text(
                              '${alarms[index].toString().split(" ")[0] + " " + alarms[index].toString().split(" ")[1]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.matSari,
                                  fontFamily: "SourceSansPro"),
                            ),
                            trailing: Text(
                              '${alarms[index].toString().split(" ")[2]}',
                              style: TextStyle(
                                fontSize: 15,
                                color: MyColors.matSari,
                                fontFamily: "SourceSansPro",
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                              caption: 'Alarmı Sil',
                              foregroundColor: Colors.redAccent,
                              color: Color.fromRGBO(20, 20, 20, 10.0),
                              icon: Icons.alarm_add,
                              onTap: () async {
                                alarmDeleteAlert(context, index, alarms);
                              }),
                        ],
                      );
                    },
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      )
    ],
  );
}
