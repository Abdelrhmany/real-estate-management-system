import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:web2f/nulldialog.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'con2.dart';

class final_enivoice2 extends StatefulWidget {
  final_enivoice2({
    super.key,
    required this.New,
    required this.date,
    required this.custmerName,
    required this.custVateNum,
    required this.ymd,
    required this.from,
    required this.to,
    required this.unitNum,
    required this.priceTyping,
    required this.price,
    required this.vat,
    required this.y,
    required this.total,
    required this.bank,
    required this.sender,
  });

  String New = 'new';
  String custmerName = 'ahmed mohammed';
  String custVateNum = '0123456789123456';
  String ymd = 'month';
  String from = '11/3/2022';
  String to = '11/4/2022';
  String unitNum = '113';
  String priceTyping = "مائة ريال";
  String price = '100';
  String vat = '15.0';
  String y = 'نقد';
  String total = '115.0';
  String bank = '';
  String sender = '';
  String date = '';

  @override
  State<final_enivoice2> createState() => _final_enivoice2State();
}

class _final_enivoice2State extends State<final_enivoice2> {
  late Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  CollectionReference cr = FirebaseFirestore.instance.collection('AllEinvoice');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => nulldialog(
                    contant: 'جاري التجهيز للطباعة',
                  ),
                ),
              );
              screenshotController.capture(
                  delay: const Duration(milliseconds: 10));
              await screenshotController.capture().then((image) {
                setState(() {
                  _imageFile = image!;
                });
              }).catchError((onError) {
                print(onError);
              });
              final doc = pw.Document();
              var im = pw.MemoryImage(_imageFile);

              doc.addPage(pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (pw.Context context) {
                    return pw.Image(im);
                  })); // Page
              await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => doc.save());
            },
            child: const Row(
              children: [
                Icon(Icons.print_rounded),
                Text(
                  'حفظ وطباعة',
                ),
              ],
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'طباعة فاتورة',
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    'فاتورة ضريبية',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "ورثة سعيد  منصور الجشي",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'المملكة العربية السعودية-القطيف',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'الرقم الضريبي :310835220600003',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                      EinvoiceGenerator2(
                        invoiceDate: widget.date,
                        totalWithVat: widget.total,
                        vatPrice: widget.vat,
                      ),
                    ],
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' التفاصيل',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 150,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.New,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Text(
                    "  :  " 'رقم الفاتورة ',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.date,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Text(
                    "  :  " ' التاريخ ',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.price,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Text(
                    "  :  " 'المبلغ اجمالي  ',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ":" ' حررت الفاتورة ل ',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 150,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.custmerName,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const Text(
                    "  :  " 'الاسم ',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.custVateNum,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "  :  " 'الرقم الضريبي ',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 150,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 2,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' بيان الفاتورة',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    width: 150,
                  )
                ],
              ),
              Table(
                defaultColumnWidth:
                    FixedColumnWidth(MediaQuery.of(context).size.width / 4.5),
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.solid, width: 2),
                children: [
                  const TableRow(children: [
                    Column(children: [
                      Text(' الاجمالي', style: TextStyle(fontSize: 22))
                    ]),
                    Column(children: [
                      Text('المبلغ', style: TextStyle(fontSize: 22))
                    ]),
                    Column(children: [
                      Text('المدة', style: TextStyle(fontSize: 22))
                    ]),
                    Column(children: [
                      Text('الوصف', style: TextStyle(fontSize: 22))
                    ]),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.price,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Text(
                                  '            المجموع الجزئي',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.vat,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Text(
                                  '                         الضريبة',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 1,
                                  width: 200,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.total,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Text(
                                  '        صافي مبلغ الاجمالي',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ],
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          const Text(
                            '   ريال سعودي  فقط لاغير   ',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            widget.price,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '''
لمدة ${widget.ymd}
من تاريخ ${widget.from}
الي تاريخ${widget.to}

''',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '''
ايجار وحدة سكنية رقم ${widget.unitNum.split(
                              '=unitNum',
                            ).first}
بالعقار رقم ${widget.unitNum.split(',')[1].split('=buildNum').first}
''',
                        style: const TextStyle(fontSize: 22),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
