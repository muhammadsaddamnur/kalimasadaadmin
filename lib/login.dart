import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/core/vigenerecipher.dart';
import 'package:kalimasadaadmin/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
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

    // setState(() {
    //   _konfirmasi = fb
    //       .database()
    //       .ref("pesanan").child(widget.firebaseKey).onValue;

    //       .toString();
    // });
  }

  login(email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ref = fb.database().ref("account");
    // .child("purchase_status");
    var a = ref
        .orderByChild('email')
        .equalTo(VigenereCipher.encrypt(email, 'badriyah'));
    a.onValue.listen((event) async {
      Map<dynamic, dynamic> map = event.snapshot.val();
      if (map != null) {
        if (VigenereCipher.encrypt(password, 'badriyah') ==
            map.values.toList()[0]['password'].toString()) {
          if (VigenereCipher.decrypt(
                  map.values.toList()[0]['role'].toString(), 'badriyah') ==
              'admin') {
            await prefs.setString(
                'email', VigenereCipher.encrypt(email, 'badriyah'));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          } else {
            Toast.show('Anda Bukan Admin', context);
          }
        } else {
          Toast.show('Password Salah', context);
        }
      } else {
        Toast.show('Email Tidak Ditemukan', context);
      }

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
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
          RaisedButton(
              child: Text('Login'),
              onPressed: () {
                login(email.text, password.text);
              })
        ],
      ),
    );
  }
}
