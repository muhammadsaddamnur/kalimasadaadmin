import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/detailproduk.dart';

import 'detailpesanan.dart';

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  fb.DatabaseReference ref;

  init() {
    setState(() {
      ref = fb.database().ref("produk");
    });

    // ref.onValue.listen((e) {
    //   debugPrint(e.snapshot.val().toString());
    // });

    // ref.onValue.listen((snapshot) {
    //   Map<dynamic, dynamic> map = snapshot.snapshot.val();
    //   debugPrint(map.values.toList()[0]['email'].toString());
    // });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.val();
              List<String> key = map.keys.toList();

              return Column(
                children: [
                  RaisedButton(
                      child: Text('Tambah'),
                      onPressed: () async {
                        await ref.push().set({
                          "harga": 0,
                          "material": "",
                          "nama": "",
                          "image": [
                            'https://firebasestorage.googleapis.com/v0/b/namdua-d4db2.appspot.com/o/image%2Flogo3.jpg?alt=media&token=776b24ac-d7b8-44e6-a7f3-9e616c34f3c6'
                          ],
                          "note": "",
                          "kategori": ""
                        });
                      }),
                  Expanded(
                    child: ListView.builder(
                        itemCount: map.values.toList().length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                            child: Card(
                              child: ListTile(
                                title: Text(map.values
                                    .toList()[index]['nama']
                                    .toString()),
                                subtitle: Text(map.values
                                        .toList()[index]['kategori']
                                        .toString() +
                                    ' - ' +
                                    map.values
                                        .toList()[index]['material']
                                        .toString()),
                                onTap: () {
                                  debugPrint(key[index].toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailProduk(
                                                firebaseKey: key[index],
                                              )));
                                  // debugPrint(map.keys.toString());
                                },
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      ref.child(key[index]).remove();
                                    }),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(
                child: Container(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}
