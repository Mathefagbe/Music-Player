import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/ui/colors/colors.dart';

class CustomThemes {
  static ThemeData darktheme() {
    return ThemeData(
        dividerColor: AppColors.darkgrey,
        indicatorColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: AppColors.darkgerytab),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkgrey,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: AppColors.darkgrey,
              statusBarBrightness: Brightness.light),
        ),
        scaffoldBackgroundColor: AppColors.darkgerytab,
        textTheme: lighttext);
  }

  static ThemeData lighttheme() {
    return ThemeData.light().copyWith(
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.black,
      ),
      iconTheme: IconThemeData(color: AppColors.black),
      indicatorColor: AppColors.black,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.grey,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: TextStyle(
            color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: AppColors.greywhite,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.grey,
            statusBarBrightness: Brightness.dark),
      ),
      scaffoldBackgroundColor: AppColors.white,
      textTheme: darktext,
    );
  }

  static TextTheme lighttext = TextTheme(
    headline5: TextStyle(
      color: AppColors.white,
    ),
    headline4: TextStyle(color: AppColors.white),
    bodyText1: TextStyle(color: AppColors.greycolor),
    headline1: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
    headline2: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
    headline3: TextStyle(fontWeight: FontWeight.w400, color: AppColors.white),
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );

  static TextTheme darktext = TextTheme(
    headline5: TextStyle(color: AppColors.black),
    headline4: TextStyle(color: AppColors.black),
    bodyText1: TextStyle(color: AppColors.greycolor),
    headline1: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
    headline2: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
    headline3: TextStyle(fontWeight: FontWeight.w400, color: AppColors.black),
    headline6: TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
  );
}
