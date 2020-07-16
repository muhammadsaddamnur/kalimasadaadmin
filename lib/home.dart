import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:kalimasadaadmin/detailpesanan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  fb.DatabaseReference ref;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

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
                                subtitle: Text(map.values
                                        .toList()[index]['email']
                                        .toString() +
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
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator()),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
