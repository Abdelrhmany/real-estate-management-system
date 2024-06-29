import 'package:cloud_firestore/cloud_firestore.dart';

import 'nulldialog.dart';

import 'package:flutter/material.dart';


class addaNewuser extends StatefulWidget {
  const addaNewuser({super.key});

  @override
  State<addaNewuser> createState() => _addaNewuserState();
}

class _addaNewuserState extends State<addaNewuser> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافة مستخدم جديد'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: username,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: ' اسم المستخدم ',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '  كلمة السر ',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('ussers')
                    .add({'name': username.text, 'password': password.text});
                username.clear();
                password.clear();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => nulldialog(
                      contant: 'تم اضافة المستخدم بنجاح',
                    ),
                  ),
                );
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
