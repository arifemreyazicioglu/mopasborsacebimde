import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mopasborsacebimde/models/exchangelist.dart';

Future<List<Exchange>> getExchangeListFromWebApi() async {
  var apiUrl = Uri(
    scheme: "http",
    host: "192.168.1.17",
    port: 2929,
    path: "/GetExchanges",
  );

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    // ignore: deprecated_member_use
    List<Exchange> exchanges = <Exchange>[];

    try {
      json.forEach((key, value) {
        if (key == "exchanges")
          for (var exchange in value)
            exchanges.add(Exchange.fromJson(exchange));
      });
    } catch (error) {
      print(error);
    }

    return exchanges;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Exchange>> getExchangeListFromWebApiFilter() async {
  var apiUrl = Uri(
    scheme: "http",
    host: "192.168.1.17",
    port: 2929,
    path: "/GetExchanges",
  );

  final response = await http.get(apiUrl);

  final FirebaseAuth auth = FirebaseAuth.instance;
  var docId = auth.currentUser!.uid;
  DocumentReference docRef =
      FirebaseFirestore.instance.collection("Person").doc(docId);

  DocumentSnapshot? doc = await docRef.get();
  List tags = doc['exchangeList'];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> json = jsonDecode(response.body);
    List<Exchange> exchanges = <Exchange>[];
    List<Exchange> arif = <Exchange>[];

    try {
      json.forEach((key, value) {
        if (key == "exchanges")
          for (var exchange in value) {
            exchanges.add(Exchange.fromJson(exchange));
          }

        for (int i = 0; i < exchanges.length; i++) {
          if (tags.contains(exchanges[i].siteName + " " + exchanges[i].name) ==
              true) {
            arif.add(exchanges[i]);
          }
        }
      });
    } catch (error) {
      print(error);
    }

    return arif;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
