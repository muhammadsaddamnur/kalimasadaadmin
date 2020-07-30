import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/core/currency.dart';
import 'package:kalimasadaadmin/core/vigenerecipher.dart';

import 'detailpesanan.dart';

class ListPesanan extends StatefulWidget {
  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  fb.DatabaseReference ref;

  int countMenungguPembayaran = 0;
  int sumPriceMenungguPembayaran = 0;
  int countMenungguKonfirmasiPembayaran = 0;
  int sumPriceMenungguKonfirmasiPembayaran = 0;
  int countPesananDiproses = 0;
  int sumPricePesananDiproses = 0;
  int countPesananSelesai = 0;
  int sumPricePesananSelesai = 0;

  init() {
    setState(() {
      ref = fb.database().ref("pesanan");
    });
  }

  listening() async {
    ref
        .orderByChild("purchase_status")
        .equalTo("¯ÆÒç×àÈÝ±ÉßËÚÚÉÔÂÒ")
        .onValue
        .listen((event) async {
      var datasnapshot = event.snapshot;
      fb.DataSnapshot testa = datasnapshot;
      debugPrint(testa.val().length.toString());
      setState(() {
        countMenungguPembayaran = testa.val().length;
      });
      Map<dynamic, dynamic> map = testa.val();

      // debugPrint(VigenereCipher.decrypt(
      //     map.values.toList()[0]['grand_total'].toString(), 'badriyah'));
      for (var i = 0; i < testa.val().length; i++) {
        setState(() {
          sumPriceMenungguPembayaran = sumPriceMenungguPembayaran +
              int.parse(VigenereCipher.decrypt(
                  map.values.toList()[i]['grand_total'].toString(),
                  'badriyah'));
        });
      }
    });

    ref
        .orderByChild("purchase_status")
        .equalTo("¯ÆÒç×àÈÝ¬ÓàÏâÓÕÃÔÍ¹ÞÎÊÃÚÅäÊç")
        .onValue
        .listen((event) async {
      var datasnapshot = event.snapshot;
      fb.DataSnapshot testa = datasnapshot;
      debugPrint(testa.val().length.toString());
      setState(() {
        countMenungguKonfirmasiPembayaran = testa.val().length;
      });
      Map<dynamic, dynamic> map = testa.val();

      // debugPrint(VigenereCipher.decrypt(
      //     map.values.toList()[0]['grand_total'].toString(), 'badriyah'));
      for (var i = 0; i < testa.val().length; i++) {
        setState(() {
          sumPriceMenungguKonfirmasiPembayaran =
              sumPriceMenungguKonfirmasiPembayaran +
                  int.parse(VigenereCipher.decrypt(
                      map.values.toList()[i]['grand_total'].toString(),
                      'badriyah'));
        });
      }
    });

    ref
        .orderByChild("purchase_status")
        .equalTo("²Æ×Ó×ÚÏ¦ÊÔäØìÆÛ")
        .onValue
        .listen((event) async {
      var datasnapshot = event.snapshot;
      fb.DataSnapshot testa = datasnapshot;
      debugPrint(testa.val().length.toString());
      setState(() {
        countPesananDiproses = testa.val().length;
      });
      Map<dynamic, dynamic> map = testa.val();

      // debugPrint(VigenereCipher.decrypt(
      //     map.values.toList()[0]['grand_total'].toString(), 'badriyah'));
      for (var i = 0; i < testa.val().length; i++) {
        setState(() {
          sumPricePesananDiproses = sumPricePesananDiproses +
              int.parse(VigenereCipher.decrypt(
                  map.values.toList()[i]['grand_total'].toString(),
                  'badriyah'));
        });
      }
    });

    ref
        .orderByChild("purchase_status")
        .equalTo("²Æ×Ó×ÚÏµÆÐ×ÜÚÊ")
        .onValue
        .listen((event) async {
      var datasnapshot = event.snapshot;
      fb.DataSnapshot testa = datasnapshot;
      debugPrint(testa.val().length.toString());
      setState(() {
        countPesananSelesai = testa.val().length;
      });
      Map<dynamic, dynamic> map = testa.val();

      // debugPrint(VigenereCipher.decrypt(
      //     map.values.toList()[0]['grand_total'].toString(), 'badriyah'));
      for (var i = 0; i < testa.val().length; i++) {
        setState(() {
          sumPricePesananSelesai = sumPricePesananSelesai +
              int.parse(VigenereCipher.decrypt(
                  map.values.toList()[i]['grand_total'].toString(),
                  'badriyah'));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
    listening();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('Menunggu Pembayaran ($countMenungguPembayaran)'),
                ),
                Tab(
                  child: Text(
                      'Menunggu Konfirmasi Pembayaran ($countMenungguKonfirmasiPembayaran)'),
                ),
                Tab(
                  child: Text('Pesanan Diproses ($countPesananDiproses)'),
                ),
                Tab(
                  child: Text('Pesanan Selesai ($countPesananSelesai)'),
                ),
              ],
            ),
            title: Text('Pesanan'),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Total : '),
                          Text(Currency.setPrice(
                              value: sumPriceMenungguPembayaran.toString())),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: ref
                            .orderByChild("purchase_status")
                            .equalTo("¯ÆÒç×àÈÝ±ÉßËÚÚÉÔÂÒ")
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.snapshot.val() == null) {
                              return Center(
                                child: Text('Tidak Ada Data'),
                              );
                            } else {
                              Map<dynamic, dynamic> map =
                                  snapshot.data.snapshot.val();

                              List<String> key = map.keys.toList();

                              return ListView.builder(
                                  itemCount: map.values.toList().length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      child: Card(
                                        child: ListTile(
                                          title: Text(VigenereCipher.decrypt(
                                              map.values
                                                  .toList()[index]['team_name']
                                                  .toString(),
                                              'badriyah')),
                                          subtitle: Text(VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]['email']
                                                      .toString(),
                                                  'badriyah') +
                                              ' - ' +
                                              VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]
                                                          ['purchase_status']
                                                      .toString(),
                                                  'badriyah')),
                                          onTap: () {
                                            debugPrint(key[index].toString());

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPesanan(
                                                          firebaseKey:
                                                              key[index],
                                                        )));

                                            // debugPrint(map.keys.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                ],
              ),
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Total : '),
                          Text(Currency.setPrice(
                              value: sumPriceMenungguKonfirmasiPembayaran
                                  .toString())),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: ref
                            .orderByChild("purchase_status")
                            .equalTo("¯ÆÒç×àÈÝ¬ÓàÏâÓÕÃÔÍ¹ÞÎÊÃÚÅäÊç")
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.snapshot.val() == null) {
                              return Center(
                                child: Text('Tidak Ada Data'),
                              );
                            } else {
                              Map<dynamic, dynamic> map =
                                  snapshot.data.snapshot.val();

                              List<String> key = map.keys.toList();

                              return ListView.builder(
                                  itemCount: map.values.toList().length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      child: Card(
                                        child: ListTile(
                                          title: Text(VigenereCipher.decrypt(
                                              map.values
                                                  .toList()[index]['team_name']
                                                  .toString(),
                                              'badriyah')),
                                          subtitle: Text(VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]['email']
                                                      .toString(),
                                                  'badriyah') +
                                              ' - ' +
                                              VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]
                                                          ['purchase_status']
                                                      .toString(),
                                                  'badriyah')),
                                          onTap: () {
                                            debugPrint(key[index].toString());

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPesanan(
                                                          firebaseKey:
                                                              key[index],
                                                        )));

                                            // debugPrint(map.keys.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                ],
              ),
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Total : '),
                          Text(Currency.setPrice(
                              value: sumPricePesananDiproses.toString())),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: ref
                            .orderByChild("purchase_status")
                            .equalTo("²Æ×Ó×ÚÏ¦ÊÔäØìÆÛ")
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.snapshot.val() == null) {
                              return Center(
                                child: Text('Tidak Ada Data'),
                              );
                            } else {
                              Map<dynamic, dynamic> map =
                                  snapshot.data.snapshot.val();

                              List<String> key = map.keys.toList();

                              return ListView.builder(
                                  itemCount: map.values.toList().length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      child: Card(
                                        child: ListTile(
                                          title: Text(VigenereCipher.decrypt(
                                              map.values
                                                  .toList()[index]['team_name']
                                                  .toString(),
                                              'badriyah')),
                                          subtitle: Text(VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]['email']
                                                      .toString(),
                                                  'badriyah') +
                                              ' - ' +
                                              VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]
                                                          ['purchase_status']
                                                      .toString(),
                                                  'badriyah')),
                                          onTap: () {
                                            debugPrint(key[index].toString());

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPesanan(
                                                          firebaseKey:
                                                              key[index],
                                                        )));

                                            // debugPrint(map.keys.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                ],
              ),
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Total : '),
                          Text(Currency.setPrice(
                              value: sumPricePesananSelesai.toString())),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: ref
                            .orderByChild("purchase_status")
                            .equalTo("²Æ×Ó×ÚÏµÆÐ×ÜÚÊ")
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.snapshot.val() == null) {
                              return Center(
                                child: Text('Tidak Ada Data'),
                              );
                            } else {
                              Map<dynamic, dynamic> map =
                                  snapshot.data.snapshot.val();

                              List<String> key = map.keys.toList();

                              return ListView.builder(
                                  itemCount: map.values.toList().length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      child: Card(
                                        child: ListTile(
                                          title: Text(VigenereCipher.decrypt(
                                              map.values
                                                  .toList()[index]['team_name']
                                                  .toString(),
                                              'badriyah')),
                                          subtitle: Text(VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]['email']
                                                      .toString(),
                                                  'badriyah') +
                                              ' - ' +
                                              VigenereCipher.decrypt(
                                                  map.values
                                                      .toList()[index]
                                                          ['purchase_status']
                                                      .toString(),
                                                  'badriyah')),
                                          onTap: () {
                                            debugPrint(key[index].toString());

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPesanan(
                                                          firebaseKey:
                                                              key[index],
                                                        )));

                                            // debugPrint(map.keys.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            }
                          } else {
                            return Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
