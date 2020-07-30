import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/core/vigenerecipher.dart';
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
    'Pesanan Diproses',
    'Pesanan Selesai',
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
      _konfirmasi = VigenereCipher.decrypt(
          testa.val()["purchase_status"].toString(), 'badriyah');
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
      body: StreamBuilder(
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
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                      .val()[widget.firebaseKey]['team_name'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Email'),
                            Text(
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                      .val()[widget.firebaseKey]['email'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('No Telepon'),
                            Text(
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                          .val()[widget.firebaseKey]
                                      ['no_handphone'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Tanggal'),
                            Text(
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                      .val()[widget.firebaseKey]['date'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Alamat'),
                            Text(
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                      .val()[widget.firebaseKey]['address'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Jumlah Pesanan'),
                            Text(
                              '${VigenereCipher.decrypt(snapshot.data.snapshot.val()[widget.firebaseKey]['team_amount'], 'badriyah')} Pcs',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Data Pemain'),
                            InkWell(
                              onTap: () async {
                                js.context.callMethod("open", [
                                  VigenereCipher.decrypt(
                                      snapshot.data.snapshot
                                              .val()[widget.firebaseKey]
                                          ['team_player'],
                                      'badriyah')
                                ]);
                              },
                              child: Container(
                                child: Text(
                                  VigenereCipher.decrypt(
                                      snapshot.data.snapshot
                                              .val()[widget.firebaseKey]
                                          ['team_player'],
                                      'badriyah'),
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
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                          .val()[widget.firebaseKey]
                                      ['catalog_name'],
                                  'badriyah'),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Harga Satuan'),
                            Text(
                              Currency.setPrice(
                                  value: VigenereCipher.decrypt(
                                      snapshot.data.snapshot
                                          .val()[widget.firebaseKey]['price']
                                          .toString(),
                                      'badriyah')),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Jumlah Total'),
                            Text(
                              Currency.setPrice(
                                  value: VigenereCipher.decrypt(
                                      snapshot.data.snapshot
                                          .val()[widget.firebaseKey]
                                              ['grand_total']
                                          .toString(),
                                      'badriyah')),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButton(
                              value: _konfirmasi,
                              items: _listKonfirmasi
                                  .map((value) => new DropdownMenuItem(
                                      value: value, child: new Text(value)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _konfirmasi = value;
                                  ref.update({
                                    "purchase_status":
                                        "${VigenereCipher.encrypt(value, 'badriyah')}"
                                  });
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () async {
                              js.context.callMethod("open", [
                                VigenereCipher.decrypt(
                                    snapshot.data.snapshot
                                        .val()[widget.firebaseKey]['team_logo'],
                                    'badriyah')
                              ]);
                            },
                            child: Image.network(
                              VigenereCipher.decrypt(
                                  snapshot.data.snapshot
                                      .val()[widget.firebaseKey]['team_logo'],
                                  'badriyah'),
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Team Sponsor',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          snapshot.data.snapshot.val()[widget.firebaseKey]
                                      ['team_sponsor'] ==
                                  'null'
                              ? Text('---')
                              : InkWell(
                                  onTap: () async {
                                    js.context.callMethod("open", [
                                      VigenereCipher.decrypt(
                                          snapshot.data.snapshot
                                                  .val()[widget.firebaseKey]
                                              ['team_sponsor'],
                                          'badriyah')
                                    ]);
                                  },
                                  child: Image.network(
                                    VigenereCipher.decrypt(
                                        snapshot.data.snapshot
                                                .val()[widget.firebaseKey]
                                            ['team_sponsor'],
                                        'badriyah'),
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Bukti Pembayaran',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          snapshot.data.snapshot.val()[widget.firebaseKey]
                                      ['purchase_photo'] ==
                                  'null'
                              ? Text('---')
                              : InkWell(
                                  onTap: () async {
                                    js.context.callMethod("open", [
                                      VigenereCipher.decrypt(
                                          snapshot.data.snapshot
                                                  .val()[widget.firebaseKey]
                                              ['purchase_photo'],
                                          'badriyah')
                                    ]);
                                  },
                                  child: Image.network(
                                    VigenereCipher.decrypt(
                                        snapshot.data.snapshot
                                                .val()[widget.firebaseKey]
                                            ['purchase_photo'],
                                        'badriyah'),
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
