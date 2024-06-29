import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class addrentstate extends StatefulWidget {
  const addrentstate({Key? key}) : super(key: key);

  @override
  State<addrentstate> createState() => _addrentstateState();
}

class _addrentstateState extends State<addrentstate> {
  TextEditingController unitNum = TextEditingController();

  TextEditingController unitOwner = TextEditingController();

  TextEditingController buildNum = TextEditingController();

  String reintstate = 'غير مؤجر';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('اضافة الحالة الايجارية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: "رقم المبني"),
              controller: buildNum,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: "رقم الوحدة"),
              controller: unitNum,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: " اسم المستاجر  في حالة الايجار"),
              controller: unitOwner,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('غير مؤجر'),
                Radio(
                  value: reintstate,
                  groupValue: "غير مؤجر",
                  onChanged: (val) {
                    setState(() {
                      unitOwner.text = 'غير مؤجر';
                      reintstate = "غير مؤجر";
                    });
                  },
                ),
                const SizedBox(
                  width: 100,
                ),
                const Text(' مؤجر'),
                Radio(
                  value: reintstate,
                  groupValue: 'مؤجر',
                  onChanged: (val) {
                    setState(() {
                      reintstate = "مؤجر";
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                var cr = FirebaseFirestore.instance.collection('rentstate');
                await cr.add({
                  'unitNum': unitNum.text,
                  "unitOwner": unitOwner.text,
                  "buildNum": buildNum.text,
                  "rentstate": reintstate
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        nulldialog(contant: 'تمت اضافة الحالة الايجارية بنجاح'),
                  ),
                );
                unitOwner.clear();
                unitNum.clear();
                buildNum.clear();
              },
              child: const Text(
                'اضافة',
              ),
            )
          ],
        ),
      ),
    );
  }
}
