import 'package:flutter/material.dart';

class Paymentoption extends StatelessWidget {
  const Paymentoption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.assetPath,
  });

  final String title;
  final String subtitle;
  final String price;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.red)),
      child: ListTile(
        leading: Image.asset(assetPath, width: 40),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: Text(price,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onTap: () {
          // Handle payment action
        },
      ),
    );
  }
}
