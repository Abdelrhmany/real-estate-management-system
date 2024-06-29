import 'package:cloud_firestore/cloud_firestore.dart';

import 'addaNewuse.dart';
import 'deletusername.dart';
import 'editadminpassword.dart';

import 'package:flutter/material.dart';

import 'allusers.dart';

class setting extends StatelessWidget {
  const setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: 4,
            childAspectRatio: 2,
            mainAxisSpacing: 10),
        padding: const EdgeInsets.all(10),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const addaNewuser(),
                ),
              );
            },
            child: const Text(
              'اضافة مستخدم',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => deletusername(),
                ),
              );
            },
            child: const Text(
              'حذف مستخدم',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              List list = [];
              var cr =
                  await FirebaseFirestore.instance.collection('ussers').get();
              for (var element in cr.docs) {
                list.add(element.data());
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => allUsers(
                    list: list,
                  ),
                ),
              );
            },
            child: const Text(
              'كل المستخدمين',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const adetadmin(),
                  ),
                );
              },
              child: const Text('تعديل كلمة سر مدير النظام'))
        ],
      ),
    );
  }
}
