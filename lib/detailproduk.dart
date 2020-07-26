import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:universal_html/prefer_universal/html.dart' as html;

class DetailProduk extends StatefulWidget {
  final dynamic firebaseKey;
  DetailProduk({this.firebaseKey});
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  fb.DatabaseReference ref;
  fb.DataSnapshot testa;
  TextEditingController name = TextEditingController();
  TextEditingController material = TextEditingController();
  TextEditingController kategori = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController note = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    test();
  }

  test() async {
    ref = fb.database().ref("produk").child(widget.firebaseKey);
    // .child("purchase_status");
    ref.onValue.listen((event) {
      var datasnapshot = event.snapshot;
      testa = datasnapshot;
      name.text = testa.val()["nama"].toString();
      kategori.text = testa.val()["kategori"].toString();
      material.text = testa.val()["material"].toString();
      harga.text = testa.val()["harga"].toString();
      note.text = testa.val()["note"].toString();

      debugPrint(testa.val()["purchase_status"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalimasada Admin'),
      ),
      body: StreamBuilder(
          stream: fb.database().ref("produk").onValue,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Card(
                    child: Container(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.snapshot
                              .val()[widget.firebaseKey]["image"]
                              .length +
                          1,
                      itemBuilder: (context, index) {
                        return index ==
                                snapshot.data.snapshot
                                    .val()[widget.firebaseKey]["image"]
                                    .length
                            ? InkWell(
                                onTap: () async {
                                  var mediaData =
                                      await ImagePickerWeb.getImageInfo;
                                  String mimeType =
                                      mime(Path.basename(mediaData.fileName));
                                  html.File mediaFile = html.File(
                                      mediaData.data,
                                      mediaData.fileName,
                                      {'type': mimeType});

                                  fb.StorageReference storageRef = fb
                                      .storage()
                                      .ref('image/${mediaFile.name}');
                                  fb.UploadTaskSnapshot uploadTaskSnapshot =
                                      await storageRef
                                          .put(mediaData.data)
                                          .future;

                                  Uri imageUri = await uploadTaskSnapshot.ref
                                      .getDownloadURL();
                                  List<dynamic> list = snapshot.data.snapshot
                                      .val()[widget.firebaseKey]["image"];
                                  list.add(imageUri.toString());
                                  ref.update({"image": list});
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              )
                            : Card(
                                child: Stack(
                                  children: [
                                    Image.network(
                                      snapshot.data.snapshot
                                              .val()[widget.firebaseKey]
                                          ["image"][index],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: InkWell(
                                        onTap: () {
                                          List<dynamic> list = snapshot
                                                  .data.snapshot
                                                  .val()[widget.firebaseKey]
                                              ["image"];
                                          list.removeAt(index);
                                          ref.update({"image": list});
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                      }),
                )),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: 200, child: Text('Nama Produk ')),
                        Expanded(
                            child: TextField(
                          controller: name,
                        ))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: 200, child: Text('Material ')),
                        Expanded(
                            child: TextField(
                          controller: material,
                        ))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: 200, child: Text('Kategori ')),
                        Expanded(
                            child: TextField(
                          controller: kategori,
                        ))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: 200, child: Text('Harga ')),
                        Expanded(
                            child: TextField(
                          controller: harga,
                        ))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: 200, child: Text('Note ')),
                        Expanded(
                            child: TextField(
                          maxLines: 7,
                          controller: note,
                        ))
                      ],
                    ),
                  ),
                ),
                loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        child: Text('Update'),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          Future.delayed(Duration(seconds: 1));
                          ref.update({
                            "harga": harga.text,
                            "kategori": kategori.text,
                            "material": material.text,
                            "nama": name.text,
                            "note": note.text,
                          });
                          setState(() {
                            loading = false;
                          });
                        })
              ],
            );
          }),
    );
  }
}
