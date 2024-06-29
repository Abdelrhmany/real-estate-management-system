import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'first.dart';
import 'nulldialog.dart';

class adminlog extends StatelessWidget {
  adminlog({super.key});
  TextEditingController adminname = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تسجيل الدخول لصفحة مدير النظام'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: 'الاسم '),
            controller: adminname,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(hintText: 'كلمة السر '),
            controller: password,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              List ll = [];
              var fire = FirebaseFirestore.instance;
              var cr = await fire
                  .collection('admin')
                  .where('user', isEqualTo: adminname.text)
                  .where('password', isEqualTo: password.text)
                  .get();
              for (var element in cr.docs) {
                ll.add(element.data());
              }
              if (ll.isNotEmpty) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const first(),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: 'كلمة المرور او المستخدم غير صحيح',
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'تسجيل الدخول',
            ),
          )
        ],
      ),
    );
  }
}
