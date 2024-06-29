import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class addUnits extends StatelessWidget {
  addUnits({super.key, required this.buildNum, required this.addres});
  TextEditingController unit = TextEditingController();

  var buildNum = '';
  var addres = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("اضافة وحدة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: unit,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'اضافة شقة او محل عن طريق الرقم',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                var fire = FirebaseFirestore.instance;
                List list = [];
                var cr = await FirebaseFirestore.instance
                    .collection('Buildings')
                    .where('build', isEqualTo: buildNum)
                    .get();
                int indexx = cr.toString().split(',').length;
                var intValue = Random().nextInt(10);
                intValue = Random().nextInt(100) + 50 + indexx;
                if (cr.toString().split(',').length > 1) {
                  String? id;
                  var idd = await FirebaseFirestore.instance
                      .collection('Buildings')
                      .where('build', isEqualTo: buildNum)
                      .get();
                  for (var element in idd.docs) {
                    id = element.id;
                  }
                  await fire
                      .collection('Buildings')
                      .doc(id)
                      .update({'unit$intValue': unit.text});
                } else {
                  await fire.collection('Buildings').add({
                    'build': buildNum,
                    'unit1': unit.text,
                    'address': addres
                  });
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        nulldialog(contant: 'تمت اضافة الوحدة بنجاح')));
                unit.clear();
              },
              child: const Text('التالي'),
            )
          ],
        ),
      ),
    );
  }
}
