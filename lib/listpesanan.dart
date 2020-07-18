import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

import 'detailpesanan.dart';

class ListPesanan extends StatefulWidget {
  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  fb.DatabaseReference ref;

  init() {
    setState(() {
      ref = fb.database().ref("pesanan");
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
              return ListView.builder(
                  itemCount: map.values.toList().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: Card(
                        child: ListTile(
                          title: Text(map.values
                              .toList()[index]['team_name']
                              .toString()),
                          subtitle: Text(
                              map.values.toList()[index]['email'].toString() +
                                  ' - ' +
                                  map.values
                                      .toList()[index]['purchase_status']
                                      .toString()),
                          onTap: () {
                            debugPrint(key[index].toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPesanan(
                                          firebaseKey: key[index],
                                        )));
                            // debugPrint(map.keys.toString());
                          },
                        ),
                      ),
                    );
                  });
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
