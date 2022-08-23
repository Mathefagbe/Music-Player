import 'package:flutter/cupertino.dart';
import 'package:music_player/core/db/db.dart';
import 'package:music_player/ui/fonts/fonts.dart';

class Themes extends ChangeNotifier {
  bool index;
  Themes({required this.index});

  void changeindex() {
    index = !index;
    Database.init.insert(index);
    notifyListeners();
  }
}
