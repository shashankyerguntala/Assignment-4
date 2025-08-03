import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final IconData icon;

  const Chips({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color.fromRGBO(59, 59, 59, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      label: Icon(icon, size: 25),
      labelPadding: EdgeInsets.all(2),
    );
  }
}
