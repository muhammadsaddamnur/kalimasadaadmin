import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  fb.initializeApp(
      apiKey: "AIzaSyCEJlYkwUuvdOZc-nf63QjGKhewQjHSJyE",
      authDomain: "namdua-d4db2.firebaseapp.com",
      databaseURL: "https://namdua-d4db2.firebaseio.com",
      projectId: "namdua-d4db2",
      storageBucket: "namdua-d4db2.appspot.com",
      messagingSenderId: "686095748714",
      appId: "1:686095748714:web:9856c4dbc685050e34c413",
      measurementId: "G-96Z4Q3QNZ0");
  // fb.DatabaseReference ref = fb.database().ref("pesanan");
  // // ref.onValue.listen((e) {
  // //   debugPrint(e.snapshot.val().toString());
  // // });

  // ref.onValue.listen((snapshot) {
  //   Map<dynamic, dynamic> map = snapshot.snapshot.val();
  //   debugPrint(map.values.toList()[0]['email'].toString());
  // });

  // ref.onValue.listen((e) {
  //   DataSnapshot datasnapshot = e.snapshot;
  //   // Do something with datasnapshot
  // });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
