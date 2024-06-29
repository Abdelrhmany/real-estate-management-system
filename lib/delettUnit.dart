import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class delettUnit extends StatelessWidget {
  TextEditingController uintId = TextEditingController();
  TextEditingController builNum = TextEditingController();

  delettUnit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('حذف وحدة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: "رقم المبني"),
            controller: builNum,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: 'الرقم التعريفي للوحدة id',
            ),
            controller: uintId,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              Map orgmap = {};
              var c = FirebaseFirestore.instance.collection('Buildings');
              var cr = await c.where('build', isEqualTo: builNum.text).get();
              String ?id;
              for (var element in cr.docs) {
                  id = element.id;
                  orgmap = element.data();
                }
              Map<String, dynamic> newmap = orgmap.remove(uintId.text);
              c.doc(id).set(newmap);

              uintId.clear();
              builNum.clear();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => nulldialog(
                    contant: 'تم حذف الوحدة بنجاح',
                  ),
                ),
              );
            },
            child: const Text(
              'حذف وحده',
            ),
          )
        ],
      ),
    );
  }
}
