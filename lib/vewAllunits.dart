import 'package:flutter/material.dart';


class vewAllunits extends StatelessWidget {
  vewAllunits({super.key, required this.allUnits});
  List allUnits = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('كل الوحدات'),
      ),
      body: ListView.builder(
        itemCount: allUnits.length,
        itemBuilder: (BuildContext context, int i) {
          List list = [];
          int len = 1000;
          int z = 0;
          while (z < len) {
            z++;
            if (allUnits[i]['unit$z'] != null) {
              list.add('(id:unit$z)' "    " '${allUnits[i]['unit$z']}' 'وحده رقم');
              list.add('\n');
              list.add('\n');
            }
          }
          if (allUnits.isNotEmpty) {
            return Container(
              color: Colors.blue[100],
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 10,
                  ),
                  Text(
                    '${allUnits[i]['build']}' '  المبني رقم',
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${allUnits[i]['address']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    list
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(
                          ']',
                          '',
                        )
                        .replaceAll(',', ''),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
