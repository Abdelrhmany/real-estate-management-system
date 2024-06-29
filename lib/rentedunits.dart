import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'nulldialog.dart';

class rented extends StatelessWidget {
  rented({super.key, required this.list});
  List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الوحدات المؤجرة'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                color: Colors.blue[200],
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        List allmaps = [];
                        var c =
                            FirebaseFirestore.instance.collection('rentstate');
                        var cr = await c
                            .where('rentstate', isEqualTo: "مؤجر")
                            .where('buildNum',
                                isEqualTo: list[index]['buildNum'])
                            .where('unitNum', isEqualTo: list[index]['unitNum'])
                            .get();
                        String ?id;
                        for (var element in cr.docs) {
                          id = element.id;
                        }

                        for (var element in cr.docs) {
                          allmaps.add(element.data());
                        }
                        // ignore: avoid_print
                        print(id);
                        Map<String, dynamic> newmap = allmaps[0];
                        await c.doc(id).update(
                            {'rentstate': 'غير مؤجر', "unitOwner": 'لايوجد'});
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => nulldialog(
                              contant:
                                  'تم نقل الوحده بنجاح الي الوحدات الشاغرة',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'اضافة الي الوحدات الشاغرة',
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          list[index]['buildNum'] + ":" + 'رقم المبني',
                          style: const TextStyle(fontSize: 22),
                        ),
                        Text(
                          'الحالة ' ":" + list[index]['rentstate'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'المستاجر ' ":" + list[index]['unitOwner'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          list[index]['unitNum'] + ":" + 'رقم الوحدة',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
