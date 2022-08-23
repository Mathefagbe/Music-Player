// import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/core/db/db.dart';
import 'package:music_player/core/models/songsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cyclemodes.dart';

class Buttons extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioPlayer get player => _audioPlayer;

  List<SongsModel> val = [];

  void playlist(List<SongsModel> value, int inde) async {
    val = value;
    notifyListeners();
    final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: List.generate(value.length, (index) {
          return AudioSource.uri(Uri.file(value[index].data),
              tag: MediaItem(
                id: value[index].id.toString(),
                title: value[index].title,
              ));
        }));
    await _audioPlayer.setAudioSource(playlist, initialIndex: inde);
    await _audioPlayer.play();
  }

  void skiptoNext() async {
    await _audioPlayer.seekToNext();
  }

  void skiptoPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  void looped(LoopMode value) async {
    int indexvalue = (cycleModes.indexOf(value) + 1) % cycleModes.length;
    Database.init.insertloop(indexvalue);
    player.setLoopMode(
      cycleModes[indexvalue],
    );
  }

  void getloop() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    player.setLoopMode(
      cycleModes[pref.getInt("index") ?? 0],
    );
  }

  // @override
  void remove() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
