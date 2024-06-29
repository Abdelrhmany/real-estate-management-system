import 'package:flutter/material.dart';

import 'nulldialog.dart';

class reprts extends StatelessWidget {
  reprts({super.key, required this.allmaps});
  List allmaps;
  double vat = 0;
  double price = 0;
  double total = 0;
  x() {
    for (var element in allmaps) {
      vat = vat + double.parse(element['vat']);
      price = price + double.parse(element['price']);
      total = total + double.parse(element['total']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.green)),
            onPressed: () {
              x();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => nulldialog(
                    contant:
                        'اجمالي الضريبة :$vat,\n \nاجمالي المبالغ بدون الضريبة :$price',
                  ),
                ),
              );
            },
            child: const Text(
              'عرض الاجمالي',
            ),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              allmaps[0]['date'],
            ),
            Text(
              allmaps.last['date'],
            ),
            const Text(
              'كل التقارير',
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: allmaps.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 150,
              color: Colors.blue[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اجمالي الفاتورة:   : ' + allmaps[index]['total'],
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'مبلغ الضريبة: ' + allmaps[index]['vat'],
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'المبلغ قبل الضريبة: ' + allmaps[index]['price'],
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    '  اسم العميل: ' + allmaps[index]['custmerName'],
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
