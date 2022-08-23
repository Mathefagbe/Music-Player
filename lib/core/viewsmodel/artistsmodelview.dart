import 'package:music_player/core/models/artistmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artistmodelview {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<Artistmodel>> query() {
    return _audioQuery
        .queryArtists(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    )
        .then((value) {
      List<Artistmodel> artist = [];
      value.map((e) {
        if (e.artist != "<unknown>") {
          artist.add(Artistmodel(
            id: e.id,
            artist: e.artist,
            tracks: e.numberOfTracks ?? 0,
          ));
        }
      }).toList();
      return artist;
    });
  }
}
