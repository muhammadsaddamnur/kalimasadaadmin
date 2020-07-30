import 'package:flutter/material.dart';
import 'package:kalimasadaadmin/core/vigenerecipher.dart';

class TestVigenere extends StatefulWidget {
  static const String route = '/testvigenere';
  @override
  _TestVigenereState createState() => _TestVigenereState();
}

class _TestVigenereState extends State<TestVigenere> {
  TextEditingController planText1 = TextEditingController();
  TextEditingController planText2 = TextEditingController();
  TextEditingController key1 = TextEditingController();
  TextEditingController key2 = TextEditingController();
  TextEditingController cipherText1 = TextEditingController();
  TextEditingController cipherText2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text('Plan Text'),
            TextField(
              controller: planText1,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Key'),
            TextField(
              controller: key1,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Cipher Text'),
            TextField(
              controller: cipherText1,
            ),
            SizedBox(
              height: 20,
            ),
            planText1.text == null
                ? SizedBox()
                : Container(
                    color: Colors.red,
                    child: Row(
                        children: List<Widget>.generate(cipherText1.text.length,
                            (index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              planText1.text[index].codeUnitAt(0).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              planText1.text[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cipherText1.text[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cipherText1.text[index].codeUnitAt(0).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    })),
                  ),
            RaisedButton(
                child: Text('Enkripsi'),
                onPressed: () {
                  setState(() {
                    cipherText1.text =
                        VigenereCipher.encrypt(planText1.text, key1.text);
                  });
                }),
            SizedBox(
              height: 50,
            ),
            Divider(),
            Text('Cipher Text'),
            TextField(
              controller: cipherText2,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Key'),
            TextField(
              controller: key2,
            ),
            SizedBox(
              height: 20,
            ),
            Text('Plan Text'),
            TextField(
              controller: planText2,
            ),
            SizedBox(
              height: 20,
            ),
            planText2.text == null
                ? SizedBox()
                : Container(
                    color: Colors.blue,
                    child: Row(
                        children: List<Widget>.generate(cipherText2.text.length,
                            (index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cipherText2.text[index].codeUnitAt(0).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cipherText2.text[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              planText2.text[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              planText2.text[index].codeUnitAt(0).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    })),
                  ),
            RaisedButton(
                child: Text('Dekripsi'),
                onPressed: () {
                  setState(() {
                    planText2.text =
                        VigenereCipher.decrypt(cipherText2.text, key2.text);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
