import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class adetadmin extends StatelessWidget {
  const adetadmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cr = FirebaseFirestore.instance
        .collection('admin')
        .doc("55aelIcdTOVWfluCeVc2");
    TextEditingController name = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تعديل كلمة السر لمدير النظام'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            controller: name,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await cr.update({'password': name.text});
                name.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: 'تم تعديل كلمة السر بنجاح',
                    ),
                  ),
                );
              },
              child: const Text('تاكيد كلمةالسر الجديدة'))
        ],
      ),
    );
  }
}
