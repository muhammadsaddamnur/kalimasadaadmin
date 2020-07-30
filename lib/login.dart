import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/core/vigenerecipher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  fb.DatabaseReference ref;
  fb.DataSnapshot testa;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String emailCompare;
  String passwordCompare;

  @override
  void initState() {
    super.initState();
    test();
    // setState(() {
    //   _konfirmasi = fb
    //       .database()
    //       .ref("pesanan").child(widget.firebaseKey).onValue;

    //       .toString();
    // });
  }

  test() async {
    ref = fb.database().ref("account");
    // .child("purchase_status");
    var a = ref.orderByChild('email').equalTo('ÄÂÈäÒòÂÐÃÓÍìÔò¢ÈÑÓÒåËÑÎ');
    a.onValue.listen((event) {
      Map<dynamic, dynamic> map = event.snapshot.val();

      debugPrint(map.values.toList()[0]['gender'].toString());
    });
    // debugPrint(.toString());

    // ref.onValue.listen((event) {
    //   var datasnapshot = event.snapshot;
    //   testa = datasnapshot;

    //   _konfirmasi = VigenereCipher.decrypt(
    //       testa.val()["purchase_status"].toString(), 'badriyah');
    //   debugPrint(testa.val()["purchase_status"].toString());
    // });
    // _messagesRef = _database.reference().child("produk");
    // testa.onValue.once().then((DataSnapshot snapshot) {
    //   debugPrint(snapshot.value.toString());
    // });
    // debugPrint(a.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            controller: email,
          ),
          TextField(
            controller: password,
          ),
          RaisedButton(child: Text('Login'), onPressed: () {})
        ],
      ),
    );
  }
}
