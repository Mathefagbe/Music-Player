import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Database._();
  static final Database init = Database._();

  void insert(bool themetype) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("theme", themetype);
  }

  void insertloop(int index) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("index", index);
  }
}
