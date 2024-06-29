import 'package:flutter/material.dart';

import 'addUnits.dart';

class addNeawbuilding extends StatelessWidget {
  addNeawbuilding({Key? key}) : super(key: key);

  TextEditingController buildingNum = TextEditingController();

  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('اضافة مبني جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: buildingNum,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'رقم المبني ',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: address,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'عنوان المبني ',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                String adres = address.text;
                String buildNum = buildingNum.text;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => addUnits(
                      buildNum: buildNum,
                      addres: adres,
                    ),
                  ),
                );
              },
              child: const Text('التالي'),
            )
          ],
        ),
      ),
    );
  }
}
