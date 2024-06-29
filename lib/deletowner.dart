import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web2f/nulldialog.dart';

class deletowner extends StatefulWidget {
  deletowner({super.key, required this.all});
  List all = [];

  @override
  State<deletowner> createState() => _deletownerState();
}

class _deletownerState extends State<deletowner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('حذف بيانات مستخدمين'),
      ),
      body: ListView.builder(
          itemCount: widget.all.length,
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  String ?id;
                  await FirebaseFirestore.instance
                      .collection('owners')
                      .where('data', isEqualTo: widget.all[i]['data'])
                      .get()
                      .then((value) {
                    for (var element in value.docs) {
                      setState(() {
                        id = element.id;
                      });
                    }
                  });

                  await FirebaseFirestore.instance
                      .collection('owners')
                      .doc(id)
                      .delete();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => nulldialog(
                        contant: 'تم الحذف بنجاح',
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.blue[200],
                  height: 75,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.all[i]['data'].toString().split('/n')[1] +
                            "   " +
                            ' الرقم الضريبي   ',
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        '${widget.all[i]['data'].toString().split('/n').first}     الاسم  ',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
