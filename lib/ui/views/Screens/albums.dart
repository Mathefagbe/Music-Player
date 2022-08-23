import 'package:flutter/material.dart';
import 'package:music_player/core/models/album.dart';
import 'package:music_player/ui/fonts/fonts.dart';
import 'package:music_player/ui/views/Screens/artistchecker.dart';
import 'package:music_player/ui/views/widgets/nullartwork.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Album extends StatelessWidget {
  Album({Key? key}) : super(key: key);
  final AppFonts _appFonts = AppFonts();
  @override
  Widget build(BuildContext context) {
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    var textfont = _appFonts.textfont(context);
    return Consumer<List<Albummodel>?>(
      builder: (context, value, child) => value == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Artistchecker(
                                artistname: value[index].artist)));
                  },
                  child: ListTile(
                    title: Text(value[index].album,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(fontSize: textfont * 0.020)),
                    subtitle: Text("${value[index].tracks} song",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: textfont * 0.018)),
                    leading: SizedBox(
                      height: height * 0.054,
                      width: width * 0.111,
                      child: QueryArtworkWidget(
                        id: value[index].id,
                        type: ArtworkType.ALBUM,
                        artworkHeight: height * 0.054,
                        artworkWidth: width * 0.111,
                        artworkBorder: BorderRadius.circular(10),
                        nullArtworkWidget: Artworks(
                          height: height * 0.054,
                          width: width * 0.111,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
