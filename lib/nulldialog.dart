import 'package:flutter/material.dart';

class nulldialog extends StatelessWidget {
  nulldialog({super.key, required this.contant});
  String contant;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          content: Text(
            contant,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('رجوع'))
      ],
    );
  }
}
