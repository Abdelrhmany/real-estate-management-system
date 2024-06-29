import 'package:flutter/material.dart';

class allUsers extends StatelessWidget {
  allUsers({required this.list, super.key});
  List list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue[200],
                height: 75,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      list[i]['password'] + '    ' + 'كلمة السر  ',
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      list[i]['name'] + "   " + 'اسم المستخدم   ',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
