import 'package:cloud_firestore/cloud_firestore.dart';

import 'nulldialog.dart';
import 'password.dart';
import 'package:flutter/material.dart';


class usarname extends StatelessWidget {
  usarname({Key? key}) : super(key: key);

  TextEditingController username = TextEditingController();

  List users = [];

  var fire = FirebaseFirestore.instance;

  getusers() async {
    var ff = await fire
        .collection('ussers')
        .where('name', isEqualTo: username.text)
        .get();
    for (var element in ff.docs) {
      users.add(element.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: username,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'اسم المستخدم '),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await getusers();
                if (users.isEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: 'اسم المستخدم الذي ادخلته غير صحيح',
                    ),
                  ));
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => password(
                        passworddd: users[0]['password'],
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'التالي',
              ),
            )
          ],
        ),
      ),
    );
  }
}
