import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/detailpesanan.dart';
import 'package:kalimasadaadmin/listpesanan.dart';
import 'package:kalimasadaadmin/tambahproduk.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // init();
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
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
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
                label: Text('Tambah Produk'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.exit_to_app),
                selectedIcon: Icon(Icons.exit_to_app),
                label: Text('Keluar'),
              ),
            ],
          ),
          _selectedIndex == 0 ? ListPesanan() : TambahProduk()
        ],
      ),
    );
  }
}
