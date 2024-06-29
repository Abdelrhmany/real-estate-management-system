import 'dart:math';

import 'package:advanced_search/advanced_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialog.dart';
import 'final_enivoice.dart';

class newEinvoice extends StatefulWidget {
  newEinvoice({super.key, required this.allrenters, required this.allunits});

  List<String> allrenters;
  List<String> allunits;
  @override
  State<newEinvoice> createState() => _newEinvoiceState();
}

class _newEinvoiceState extends State<newEinvoice> {
  //func
  setbank(bank) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('bank', bank);
  }

  setname(name) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('name', name);
  }

  getNameAndBank() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      sender = sh.getString('name')!;
      bank = sh.getString('bank')!;
    });
  }

  final formkey = GlobalKey<FormState>();
//المدة الايجارية
  String x = "";
  //طريقة الدفع
  String y = "";
  //مبلغ الضريبة
  double vat = 0.0;
  //الاجمالي
  String total = '';
  var selected;
  //controals
  TextEditingController name = TextEditingController();
  TextEditingController customerVatNum = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController unitNumper = TextEditingController();
  TextEditingController typingPrice = TextEditingController();
  String sender = '';
  String bank = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_card),
            SizedBox(
              width: 20,
            ),
            Text('اضافة فاتورة جديدة'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              AdvancedSearch(
                hintText: 'اختر المستأجر',
                searchItems: widget.allrenters,
                onItemTap: (index, value) async {
                  setState(() {
                    name.text = value.split('/n')[0];
                    customerVatNum.text = value.split('/n')[1];
                    selected = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AdvancedSearch(
                searchItems: widget.allunits,
                onItemTap: (i, v) {
                  setState(() {
                    unitNumper.text = v;
                  });
                },
                hintText: 'اختر الوحدة',
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.blue[100],
                width: MediaQuery.of(context).size.width,
                child: const Center(
                    child: Text(
                  'العميل ',
                  style: TextStyle(fontSize: 24),
                )),
              ),
              TextFormField(
                controller: name,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: 'الاسم '),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return 'برجاء ادخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: customerVatNum,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: 'الرقم الضريبي '),
                validator: (val) {
                  if (val.toString().length != 15) {
                    return ' يجب ان يكون الرقم الضريبي مكون من خمسة عشر رقما';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue[100],
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    'السلعه / الخدمة ',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("يوم"),
                  Radio(
                      value: x,
                      groupValue: "يوم",
                      onChanged: (val) {
                        setState(() {
                          x = "يوم";
                        });
                      }),
                  const Text('شهر'),
                  Radio(
                      value: x,
                      groupValue: 'شهر',
                      onChanged: (val) {
                        setState(() {
                          x = 'شهر';
                        });
                      }),
                  const Text('عام'),
                  Radio(
                      value: x,
                      groupValue: "عام",
                      onChanged: (val) {
                        setState(() {
                          x = "عام";
                        });
                      }),
                  const Text(
                    ':المدة الايجارية ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextFormField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(20150))
                      .then(
                    (value) {
                      setState(() {
                        from.text = value.toString().split(' ').first;
                      });
                    },
                  );
                },
                controller: from,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: 'ابتداء من '),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "  برجاء ادخال تاريخ البدية";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(20150))
                      .then(
                    (value) {
                      setState(() {
                        to.text = value.toString().split(' ').first;
                      });
                    },
                  );
                },
                controller: to,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'الي',
                ),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return " برجاء ادخال تاريخ انتهاء المدة";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: unitNumper,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'رقم الوحدة',
                ),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return " برجاء ادخال رقم الوحدة";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue[100],
                width: MediaQuery.of(context).size.width,
                child: const Center(
                    child: Text(
                  ' المبلغ ',
                  style: TextStyle(fontSize: 24),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: typingPrice,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'المبلغ كتابة',
                ),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "المبلغ كتابة";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: price,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "المبلغ عددي",
                ),
                validator: (val) {
                  if (val.toString().isEmpty) {
                    return "المبلغ عددي";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("نقد"),
                  Radio(
                      value: y,
                      groupValue: "نقد",
                      onChanged: (val) async {
                        await setname(' الدفع نقدي');
                        await setbank(' الدفع نقدي');
                        setState(() {
                          y = "نقد";
                        });
                      }),
                  const Text('شيك'),
                  Radio(
                      value: y,
                      groupValue: 'شيك',
                      onChanged: (val) async {
                        await setname('الدفع عن طريق شيك');
                        await setbank('الدفع عن طريق شيك');
                        setState(() {
                          y = 'شيك';
                        });
                      }),
                  const Text('تحويل'),
                  Radio(
                      value: y,
                      groupValue: "تحويل",
                      onChanged: (val) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const dialogg(),
                          ),
                        );
                        setState(() {
                          y = "تحويل";
                        });
                      }),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    ':طريقة الدفع  ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  Random random = Random();
                  int randomNumber = random.nextInt(100000);
                  if (formkey.currentState!.validate() && x != "") {
                    String ?id;
                    await FirebaseFirestore.instance
                        .collection('owners')
                        .where('data', isEqualTo: selected)
                        .get()
                        .then((value) => value.docs.forEach((element) {
                              setState(() {
                                id = element.id;
                              });
                            }));
                    await FirebaseFirestore.instance
                        .collection('owners')
                        .doc(id)
                        .update({
                      'data': '${name.text}/n${customerVatNum.text}/n${to.text}'
                    });
                    await getNameAndBank();
                    setState(() {
                      vat = (int.parse(price.text) * 0.15);
                      total = "${vat + (int.parse(price.text))}";
                    });

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => final_enivoice(
                          New: randomNumber.toString(),
                          custmerName: name.text,
                          custVateNum: customerVatNum.text,
                          ymd: x,
                          from: from.text,
                          to: to.text,
                          unitNum: unitNumper.text,
                          priceTyping: typingPrice.text,
                          price: price.text,
                          vat: vat.toString(),
                          y: y,
                          total: total,
                          bank: bank,
                          sender: sender,
                        ),
                      ),
                    );
                  } else if (x == "") {
                    showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                              content: Text('اختر المدة الايجارية من فضلك'),
                            ));
                  } else if (y == "") {
                    showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                              content: Text('اختر طريقة الدفع '),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                              content: Text('برجاء ملئ جميع البيانات'),
                            ));
                  }
                },
                child: const Text(
                  'التالي',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
