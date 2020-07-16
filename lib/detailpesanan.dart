import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:url_launcher/url_launcher.dart';
import 'dart:js' as js;

import 'core/currency.dart';

class DetailPesanan extends StatefulWidget {
  final dynamic firebaseKey;
  DetailPesanan({this.firebaseKey});
  @override
  _DetailPesananState createState() => _DetailPesananState();
}

class _DetailPesananState extends State<DetailPesanan> {
  fb.DatabaseReference ref;
  fb.DataSnapshot testa;
  int _selectedIndex = 0;
  List<String> _listKonfirmasi = [
    'Menunggu Pembayaran',
    'Menunggu Konfirmasi Pembayaran',
  ];
  String _konfirmasi = '';

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
    ref = fb.database().ref("pesanan").child(widget.firebaseKey);
    // .child("purchase_status");
    ref.onValue.listen((event) {
      var datasnapshot = event.snapshot;
      testa = datasnapshot;
      _konfirmasi = testa.val()["purchase_status"].toString();
      debugPrint(testa.val()["purchase_status"].toString());
    });
    // _messagesRef = _database.reference().child("produk");
    // testa.onValue.once().then((DataSnapshot snapshot) {
    //   debugPrint(snapshot.value.toString());
    // });
    // debugPrint(a.toString());
  }

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
          Expanded(
            child: StreamBuilder(
                stream: fb.database().ref("pesanan").onValue,
                builder: (context, snapshot) {
                  debugPrint(_konfirmasi.toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama Team'),
                                  Text(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['team_name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Email'),
                                  Text(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['email'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('No Telepon'),
                                  Text(
                                    snapshot.data.snapshot
                                            .val()[widget.firebaseKey]
                                        ['no_handphone'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Tanggal'),
                                  Text(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['date'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Alamat'),
                                  Text(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['address'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Jumlah Pesanan'),
                                  Text(
                                    '${snapshot.data.snapshot.val()[widget.firebaseKey]['team_amount']} Pcs',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Data Pemain'),
                                  InkWell(
                                    onTap: () async {
                                      js.context.callMethod("open", [
                                        snapshot.data.snapshot
                                                .val()[widget.firebaseKey]
                                            ['team_player']
                                      ]);
                                    },
                                    child: Container(
                                      child: Text(
                                        snapshot.data.snapshot
                                                .val()[widget.firebaseKey]
                                            ['team_player'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Katalog Name'),
                                  Text(
                                    snapshot.data.snapshot
                                            .val()[widget.firebaseKey]
                                        ['catalog_name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Harga Satuan'),
                                  Text(
                                    Currency.setPrice(
                                        value: snapshot.data.snapshot
                                            .val()[widget.firebaseKey]['price']
                                            .toString()),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Jumlah Total'),
                                  Text(
                                    Currency.setPrice(
                                        value: snapshot.data.snapshot
                                            .val()[widget.firebaseKey]
                                                ['grand_total']
                                            .toString()),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButton(
                                    value: _konfirmasi,
                                    items: _listKonfirmasi
                                        .map((value) => new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value)))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _konfirmasi = value;
                                        ref.update(
                                            {"purchase_status": "$value"});
                                      });
                                    },
                                  )
                                ],
                              ),
                            )),
                            Column(
                              children: [
                                Text(
                                  'Logo Team',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () async {
                                    js.context.callMethod("open", [
                                      snapshot.data.snapshot
                                              .val()[widget.firebaseKey]
                                          ['team_logo']
                                    ]);
                                  },
                                  child: Image.network(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['team_logo'],
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Team Sponsor',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                snapshot.data.snapshot.val()[widget.firebaseKey]
                                            ['team_sponsor'] ==
                                        'null'
                                    ? Text('---')
                                    : InkWell(
                                        onTap: () async {
                                          js.context.callMethod("open", [
                                            snapshot.data.snapshot
                                                    .val()[widget.firebaseKey]
                                                ['team_sponsor']
                                          ]);
                                        },
                                        child: Image.network(
                                          snapshot.data.snapshot
                                                  .val()[widget.firebaseKey]
                                              ['team_sponsor'],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                        ),
                                      ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
