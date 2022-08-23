import 'package:flutter/material.dart';
import 'package:music_player/core/models/songsmodel.dart';
import 'package:music_player/core/viewsmodel/buttons.dart';
import 'package:music_player/ui/fonts/fonts.dart';
import 'package:music_player/ui/views/Screens/playing.dart';
import 'package:music_player/ui/views/widgets/nullartwork.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Songs extends StatelessWidget {
  Songs({Key? key}) : super(key: key);
  final AppFonts _appFonts = AppFonts();
  @override
  Widget build(BuildContext context) {
    var textfont = _appFonts.textfont(context);
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    return Consumer<List<SongsModel>?>(
      builder: (context, value, child) => value == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    Provider.of<Buttons>(context, listen: false)
                        .playlist(value, index);
                    showModalBottomSheet(
                        isScrollControlled: true,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return PlayingScreen(
                            value: value,
                          );
                        });
                  },
                  child: ListTile(
                    title: Text(
                      value[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: textfont * 0.020),
                    ),
                    subtitle: Text(value[index].subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: textfont * 0.018)),
                    leading: SizedBox(
                      height: height * 0.054,
                      width: width * 0.111,
                      child: QueryArtworkWidget(
                        artworkHeight: height * 0.054,
                        artworkWidth: width * 0.111,
                        artworkBorder: BorderRadius.circular(10),
                        id: value[index].id,
                        type: ArtworkType.AUDIO,
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
