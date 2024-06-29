import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'getName.dart';

class unrented extends StatelessWidget {
  unrented({super.key, required this.list});
  List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الوحدات الشاغرة'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        List allmaps = [];
                        var c =
                            FirebaseFirestore.instance.collection('rentstate');
                        var cr = await c
                            .where('rentstate', isEqualTo: "غير مؤجر")
                            .where('buildNum',
                                isEqualTo: list[index]['buildNum'])
                            .where('unitNum', isEqualTo: list[index]['unitNum'])
                            .get();
                        String? id;
                        for (var element in cr.docs) {
                            id = element.id;
                          }
                        for (var element in cr.docs) {
                          allmaps.add(element.data());
                        }
                        Map<String, dynamic> newmap = allmaps[0];
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => getName(
                                    id: id!,
                                  )),
                        );
                      },
                      child: const Text(
                        'اضافة الي الوحدات المؤجرة',
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
                          style: const TextStyle(fontSize: 22),
                        ),
                        Text(
                          list[index]['unitNum'] + ":" + 'رقم الوحدة',
                          style: const TextStyle(fontSize: 22),
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
