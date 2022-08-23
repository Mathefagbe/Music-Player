import 'package:flutter/material.dart';
import 'package:music_player/ui/fonts/fonts.dart';

class Custombutton extends StatelessWidget {
  Custombutton({Key? key, required this.ontap, required this.text})
      : super(key: key);
  final VoidCallback ontap;
  final String text;
  final AppFonts _appFonts = AppFonts();
  @override
  Widget build(BuildContext context) {
    var textfont = _appFonts.textfont(context);
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 120,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontSize: textfont * 0.020),
        ),
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
