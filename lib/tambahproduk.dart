import 'package:flutter/material.dart';

class TambahProduk extends StatefulWidget {
  @override
  _TambahProdukState createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(child: Text('Gambar 1'), onPressed: () {}),
              RaisedButton(child: Text('Gambar 2'), onPressed: () {}),
              RaisedButton(child: Text('Gambar 3'), onPressed: () {}),
              RaisedButton(child: Text('Gambar 4'), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
