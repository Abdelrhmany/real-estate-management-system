import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'reports.dart';

class Einvoicereport extends StatefulWidget {
  const Einvoicereport({super.key});

  @override
  State<Einvoicereport> createState() => _EinvoicereportState();
}

class _EinvoicereportState extends State<Einvoicereport> {
  TextEditingController from = TextEditingController();

  TextEditingController to = TextEditingController();

  // String? sto;

  List<DateTime> getDays({required DateTime start, required DateTime end}) {
    final days = end.difference(start).inDays;

    return [for (int i = 0; i < days; i++) start.add(Duration(days: i))];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ملخص الفواتير'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(20150))
                    .then(
                  (value) {
                    setState(() {
                      from.text = value.toString();
                    });
                  },
                );
              },
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: " تاريخ البداية"),
              controller: from,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(20150))
                    .then(
                  (value) {
                    setState(() {
                      to.text = value.toString();
                    });
                  },
                );
              },
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: " تاريخ النهاية "),
              controller: to,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                List unfiltring = [];
                List alldayes = [];

                await FirebaseFirestore.instance
                    .collection('AllEinvoice')
                    .get()
                    .then((value) {
                  for (var element in value.docs) {
                    unfiltring.add(element.data());
                  }
                });

                DateTime s = DateTime.parse(from.text);
                DateTime t = DateTime.parse(to.text);
                List<DateTime> days = getDays(
                  start: s,
                  end: t,
                );

                for (var element in days) {
                  alldayes
                      .add('${element.year}-${element.month}-${element.day}');
                }
                List allMaps = [];

                for (var unfiltringelement in unfiltring) {
                  for (var alldayeselement in alldayes) {
                    if (unfiltringelement['date'] == alldayeselement) {
                      allMaps.add(unfiltringelement);

                      if (kDebugMode) {
                        print('suc');
                      }
                    } else {
                      if (kDebugMode) {
                        print('null');
                      }
                    }
                  }
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => reprts(
                      allmaps: allMaps,
                    ),
                  ),
                );
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
