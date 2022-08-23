import 'package:music_player/core/models/album.dart';
import 'package:music_player/core/models/artistmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Albummodelview {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<Albummodel>> query() {
    return _audioQuery
        .queryAlbums(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    )
        .then((value) {
      List<Albummodel> artist = [];
      value.map((e) {
        if (e.artist != "<unknown>") {
          artist.add(Albummodel(
              id: e.id,
              album: e.album,
              tracks: e.numOfSongs,
              artist: e.artist ?? ""));
        }
      }).toList();
      return artist;
    });
  }
}
