import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class addrenters extends StatelessWidget {
  addrenters({super.key});
  @override
  String? x;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController vatnum = TextEditingController();
    String nn = 'notavilable';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('اضافة بيانات مستأجر'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: " اسم المستاجر  "),
              controller: name,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration:
                  const InputDecoration(hintText: " الرقم الضريبي للمستاجر"),
              controller: vatnum,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('owners')
                    .add({'data': '${name.text}/n${vatnum.text} /n $nn '});
                name.clear();
                vatnum.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: 'تم اضافة بيانات المستأجر بنجاح',
                    ),
                  ),
                );
              },
              child: const Text(
                'اضافه',
              ),
            )
          ],
        ),
      ),
    );
  }
}
