import 'package:flutter/material.dart';

class vewrented extends StatelessWidget {
  vewrented({super.key, required this.list});
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
          return InkWell(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 75,
                  width: double.infinity,
                  color: Colors.blue[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'المستاجر ' ":" + list[index]['unitOwner'],
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        list[index]['unitNum'] + ":" + 'رقم الوحدة',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
