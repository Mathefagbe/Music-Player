import 'package:flutter/material.dart';

import '../../fonts/fonts.dart';

class Artworks extends StatelessWidget {
  Artworks({Key? key, required this.height, required this.width, this.size})
      : super(key: key);
  final double height;
  final double width;
  final double? size;
  final AppFonts _appFonts = AppFonts();
  @override
  Widget build(BuildContext context) {
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    return Container(
      height: height,
      width: width,
      child: Icon(
        Icons.music_note,
        size: size,
      ),
      decoration: BoxDecoration(
          color: const Color.fromARGB(243, 255, 70, 64),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
