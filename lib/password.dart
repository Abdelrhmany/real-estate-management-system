import 'firstforusers.dart';
import 'nulldialog.dart';
import 'package:flutter/material.dart';

import 'usarname.dart';

class password extends StatelessWidget {
  password({required this.passworddd, Key? key}) : super(key: key);
  String passworddd;
  TextEditingController passwordd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: passwordd,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: 'كلمة السر'),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                if (passworddd == passwordd.text) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const firstfor(),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => nulldialog(
                        contant: 'كلمة المرور خاطئة',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'التالي',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => usarname()),
                  );
                },
                child: const Text('رجوع'))
          ],
        ),
      ),
    );
  }
}
