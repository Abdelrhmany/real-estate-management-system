import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class deletusername extends StatelessWidget {
  deletusername({super.key});
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            controller: name,
            textAlign: TextAlign.center,
            decoration:
                const InputDecoration(hintText: 'اسم المستخدم المراد حذفه '),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              var cr = await FirebaseFirestore.instance
                  .collection('ussers')
                  .where('name', isEqualTo: name.text)
                  .get();

              if (cr.docs.isNotEmpty) {
                String ? id;

                for (var element in cr.docs) {
                  id = element.id;
                }

                await FirebaseFirestore.instance
                    .collection('ussers')
                    .doc(id)
                    .delete();
                name.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: "تم حذف المستخدم بنجاح ",
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: "اسم المستخدم غير موجود",
                    ),
                  ),
                );
              }
            },
            child: const Text(
              "حذف",
            ),
          )
        ],
      ),
    );
  }
}
