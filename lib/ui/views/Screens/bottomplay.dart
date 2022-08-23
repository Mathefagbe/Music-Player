import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/viewsmodel/buttons.dart';
import 'package:music_player/ui/colors/colors.dart';
import 'package:music_player/ui/fonts/fonts.dart';
import 'package:music_player/ui/views/Screens/playing.dart';
import 'package:music_player/ui/views/widgets/nullartwork.dart';
import 'package:music_player/ui/views/widgets/playbotton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class BottomPlay extends StatelessWidget {
  BottomPlay({Key? key}) : super(key: key);

  final AppFonts _appFonts = AppFonts();

  @override
  Widget build(BuildContext context) {
    var value = Provider.of<Buttons>(context).val;
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    return value.isEmpty
        ? const SizedBox()
        : Container(
            decoration: BoxDecoration(
                color: AppColors.darkgreyblck,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            padding: EdgeInsets.only(left: width * 0.014, right: width * 0.028),
            height: height * 0.082,
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _artimage(context),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _isloading(context),
                    _isplay(context),
                  ],
                )
              ],
            ));
  }

  Widget _artimage(BuildContext context) {
    var textfont = _appFonts.textfont(context);
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    var player = Provider.of<Buttons>(context).player;
    var value = Provider.of<Buttons>(context).val;
    return StreamBuilder<SequenceState?>(
        stream: player.sequenceStateStream,
        builder: (context, snapshot) {
          final index = snapshot.data?.currentIndex;
          return index == null
              ? Container()
              : InkWell(
                  onTap: () {
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
                  child: SizedBox(
                    height: double.maxFinite,
                    width: width * 0.81,
                    child: Row(
                      children: [
                        SizedBox(
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
                        SizedBox(
                          width: width * 0.014,
                        ),
                        Flexible(
                          child: Text(
                            value[index].title,
                            softWrap: true,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: textfont * 0.020),
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
  }

  Widget _isloading(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    return StreamBuilder<Duration>(
        stream: player.positionStream,
        builder: (context, snapshot) {
          final positionData = snapshot.data;
          return positionData == null
              ? Container()
              : CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  value: player.duration == null
                      ? 0.0
                      : positionData.inSeconds.toDouble() /
                          player.duration!.inSeconds.toDouble(),
                  color: Colors.black,
                );
        });
  }

  Widget _isplay(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;

          if (playing != true) {
            return IconButton(
                padding: EdgeInsets.zero,
                onPressed: player.play,
                icon: const Icon(Icons.play_arrow, size: 25));
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
                padding: EdgeInsets.zero,
                onPressed: player.pause,
                icon: const Icon(
                  Icons.pause,
                  size: 25,
                ));
          }
          return Playbotton(
            ontap: player.play,
            icon: Icons.pause,
          );
        });
  }
}
