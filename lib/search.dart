
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';

import 'final_enivoice2.dart';
import 'nulldialog.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  converTextToMap(String string, Map map) {
    List test2 = string.split(',');
    for (var element in test2) {
      var v = element.toString().split(':');
      map.addAll({v.first.trim(): v.last.trim()});
    }
  }

  TextEditingController name = TextEditingController();

  TextEditingController month = TextEditingController();

  TextEditingController year = TextEditingController();

  TextEditingController day = TextEditingController();

  Map myMap = {};

  get() async {
    String sname = name.text;
    String syear = year.text;
    String smonth = month.text;
    String sday = day.text;
    String date = '$syear-$smonth-$sday';
    var cr = await FirebaseFirestore.instance
        .collection('AllEinvoice')
        .where('custmerName', isEqualTo: sname)
        .where('date', isEqualTo: date)
        .get();
    for (var element in cr.docs) {
      myMap = element.data();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الاستعلام عن فاتورة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: name,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'الاسم '),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: day,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'يوم'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: month,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'شهر '),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: year,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'عام'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await get();

                if (myMap['time'] != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => final_enivoice2(
                      date: myMap['date'],
                      New: myMap['new'],
                      custmerName: myMap['custmerName'],
                      custVateNum: myMap['custVateNum'],
                      ymd: myMap['ymd'],
                      from: myMap['from'],
                      to: myMap['to'],
                      unitNum: myMap['unitNum'],
                      priceTyping: myMap['priceTyping'],
                      price: myMap['price'],
                      vat: myMap['vat'],
                      y: myMap['y'],
                      total: myMap['total'],
                      bank: myMap['bank'],
                      sender: myMap['sender'],
                    ),
                  ));
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => nulldialog(
                        contant: 'لاتوجد فاتورة بهذه البيانات',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'بحث',
              ),
            )
          ],
        ),
      ),
    );
  }
}
