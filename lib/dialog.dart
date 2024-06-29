import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dialogg extends StatefulWidget {
  const dialogg({super.key});

  @override
  State<dialogg> createState() => _dialoggState();
}

class _dialoggState extends State<dialogg> {
  setbank(bank) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('bank', bank);
  }

  setname(name) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString('name', name);
  }

  TextEditingController bank = TextEditingController();
  TextEditingController name =
      TextEditingController(text: 'صالح القرشي العقارية ');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('اضافة بيانات التحويل'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: name,
                  decoration:
                      const InputDecoration(hintText: 'ادخل اسم المرسل'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  controller: bank,
                  decoration: const InputDecoration(hintText: 'ادخل اسم البنك'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      await setname(name.text);
                      await setbank(bank.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'موافق',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
