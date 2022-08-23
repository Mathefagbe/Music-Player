import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/core/permission.dart';
import 'package:music_player/core/viewsmodel/albummodelview.dart';
import 'package:music_player/core/viewsmodel/artistsmodelview.dart';
import 'package:music_player/core/viewsmodel/buttons.dart';
import 'package:music_player/core/viewsmodel/songsmodelview.dart';
import 'package:music_player/core/viewsmodel/themes.dart';
import 'package:music_player/ui/colors/themes.dart';
import 'package:music_player/ui/views/Screens/navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Permission.on.requestPermission();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await JustAudioBackground.init(
      androidShowNotificationBadge: true,
      notificationColor: Colors.black,
      preloadArtwork: true,
      androidNotificationChannelId: "com.example.music_player.channel.audio",
      androidNotificationChannelName: "Audio playback",
      androidNotificationOngoing: true);
  await Future.delayed(const Duration(seconds: 8))
      .then((value) => {FlutterNativeSplash.remove()});
  final SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
      create: (context) => Themes(index: pref.getBool("theme") ?? false),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
            create: (context) => Querys().query(), initialData: null),
        FutureProvider(
            create: (context) => Artistmodelview().query(), initialData: null),
        FutureProvider(
            create: (context) => Albummodelview().query(), initialData: null),
        ChangeNotifierProvider<Buttons>(create: (context) => Buttons()),
      ],
      child: Consumer<Themes>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value.index
              ? CustomThemes.lighttheme()
              : CustomThemes.darktheme(),
          home: const MusicPlayer(),
        ),
      ),
    );
  }
}
