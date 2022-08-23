import 'package:flutter/material.dart';

class Playbotton extends StatelessWidget {
  const Playbotton({Key? key, required this.ontap, required this.icon})
      : super(key: key);
  final VoidCallback ontap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 60,
        width: 60,
        child: Icon(
          icon,
          size: 50,
          color: Colors.black,
        ),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(3, 218, 197, 0.9), shape: BoxShape.circle),
      ),
    );
  }
}
