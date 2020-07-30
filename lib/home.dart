import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/detailpesanan.dart';
import 'package:kalimasadaadmin/listpesanan.dart';
import 'package:kalimasadaadmin/login.dart';
import 'package:kalimasadaadmin/member.dart';
import 'package:kalimasadaadmin/produk.dart';
import 'package:kalimasadaadmin/tambahproduk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    checkLogin();
    super.initState();
    // init();
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  // init() {
  //   setState(() {
  //     ref = fb.database().ref("pesanan");
  //   });

  //   // ref.onValue.listen((e) {
  //   //   debugPrint(e.snapshot.val().toString());
  //   // });

  //   // ref.onValue.listen((snapshot) {
  //   //   Map<dynamic, dynamic> map = snapshot.snapshot.val();
  //   //   debugPrint(map.values.toList()[0]['email'].toString());
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalimasa Admin'),
        actions: [],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) async {
              if (index == 3) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('email');

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false);
              }
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.monetization_on),
                selectedIcon: Icon(Icons.monetization_on),
                label: Text('Pesanan'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                selectedIcon: Icon(Icons.add),
                label: Text('Produk'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Member'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.exit_to_app),
                selectedIcon: Icon(Icons.exit_to_app),
                label: Text('Keluar'),
              ),
            ],
          ),
          _selectedIndex == 0
              ? ListPesanan()
              : _selectedIndex == 1 ? Produk() : Member()
        ],
      ),
    );
  }
}
