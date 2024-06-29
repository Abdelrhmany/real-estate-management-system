import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class getName extends StatelessWidget {
  getName({Key? key, required this.id}) : super(key: key);
  TextEditingController name = TextEditingController();
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'اسم المستاجر '),
              controller: name,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                var c = FirebaseFirestore.instance.collection('rentstate');

                await c
                    .doc(id)
                    .update({'rentstate': 'مؤجر', "unitOwner": name.text});
                Navigator.of(context).pop();
              },
              child: const Text(
                'تمت',
              ),
            )
          ],
        ),
      ),
    );
  }
}
