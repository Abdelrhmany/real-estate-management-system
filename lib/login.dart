import 'package:flutter/material.dart';

import 'adminlog.dart';
import 'usarname.dart';

class log extends StatelessWidget {
  const log({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تسجيل الدخول'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 10),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => adminlog()),
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
                  '  تسجيل الدخول ك مدير النظام    ',
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => usarname()),
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
                  '  تسجيل الدخول ك مستخدم     ',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
