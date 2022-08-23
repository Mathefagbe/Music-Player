import 'package:music_player/core/models/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Querys {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongsModel>> query() {
    return _audioQuery
        .querySongs(
      path: null,
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    )
        .then((value) {
      List<SongsModel> music = [];
      value.map((e) {
        if (e.fileExtension == "mp3" &&
            e.isMusic == true &&
            e.isNotification == false &&
            e.isRingtone == false) {
          music.add(SongsModel(
              id: e.id,
              data: e.data,
              extension: e.fileExtension,
              subtitle: e.artist ?? "no artist",
              title: e.title));
        }
      }).toList();
      return music;
    });
  }

  Future<List<SongsModel>> artisquery(String artist) {
    return _audioQuery
        .querySongs(
      path: null,
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    )
        .then((value) {
      List<SongsModel> music = [];
      value.map((e) {
        if (e.fileExtension == "mp3" &&
            e.isMusic == true &&
            e.isNotification == false &&
            e.isRingtone == false &&
            e.artist == artist) {
          music.add(SongsModel(
              id: e.id,
              data: e.data,
              extension: e.fileExtension,
              subtitle: e.artist ?? "no artise",
              title: e.title));
        }
      }).toList();
      return music;
    });
  }
}
