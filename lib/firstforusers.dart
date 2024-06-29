import 'package:cloud_firestore/cloud_firestore.dart';

import 'addNewbuilding.dart';
import 'addrenters.dart';
import 'deletowner.dart';
import 'new_einvoice.dart';
import 'search.dart';
import 'unrented.dart';
import 'vewAllunits.dart';
import 'package:flutter/material.dart';

import 'Einvoicereport.dart';
import 'addrentstate.dart';
import 'delettUnit.dart';
import 'rentedunits.dart';

class firstfor extends StatelessWidget {
  const firstfor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشاشة الرئيسية'),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 10),
        children: [
          InkWell(
            onTap: () async {
              List<String> allrenters = [];
              List<String> allunits = [];
              await FirebaseFirestore.instance
                  .collection('rentstate')
                  .get()
                  .then(
                    (value) => value.docs.forEach(
                      (element) {
                        allunits.add(
                            '${element['unitNum']}=unitNum,${element['buildNum']}=buildNum,${element['unitOwner']}=unitOwner,');
                      },
                    ),
                  );
              await FirebaseFirestore.instance.collection('owners').get().then(
                    (value) => value.docs.forEach(
                      (element) {
                        allrenters.add('${element['data']}');
                      },
                    ),
                  );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      newEinvoice(allrenters: allrenters, allunits: allunits),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  'اضافة فاتورة ',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => addrenters()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  ' اضافة بيانات مستأجرين ',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const search(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  'الاستعلام عن فاتورة',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => addNeawbuilding(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  'اضافة وحدات',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              List all = [];
              var cr = await FirebaseFirestore.instance
                  .collection('Buildings')
                  .get();
              for (var element in cr.docs) {
                all.add(element.data());
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => vewAllunits(
                    allUnits: all,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  'كل الوحدات',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => delettUnit()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  'حذف وحدة',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Einvoicereport(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  ' ملخص الفواتير ',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const addrentstate(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  ' اضافة الحالة الايجارية لوحده ',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              List list = [];
              var cr = await FirebaseFirestore.instance
                  .collection('rentstate')
                  .where('rentstate', isEqualTo: 'غير مؤجر')
                  .get();
              for (var element in cr.docs) {
                list.add(element.data());
              }

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => unrented(
                    list: list,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  '  الوحدات الغير مؤجره ',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              List list = [];
              var cr = await FirebaseFirestore.instance
                  .collection('rentstate')
                  .where('rentstate', isEqualTo: 'مؤجر')
                  .get();
              for (var element in cr.docs) {
                list.add(element.data());
              }

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => rented(
                    list: list,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  '  الوحدات   المؤجره ',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              List all = [];
              await FirebaseFirestore.instance
                  .collection('owners')
                  .get()
                  .then((value) {
                for (var element in value.docs) {
                  all.add(element.data());
                }
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => deletowner(
                          all: all,
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              child: const Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  ' حذف بيانات مستأجرين ',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
