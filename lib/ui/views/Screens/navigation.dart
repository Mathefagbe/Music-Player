import 'package:flutter/material.dart';

import 'package:music_player/ui/views/Screens/bottomplay.dart';
import 'package:music_player/ui/views/Screens/home/home.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      bottomNavigationBar: BottomPlay(),
    );
  }
}
