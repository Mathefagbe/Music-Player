import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/models/songsmodel.dart';
import 'package:music_player/core/viewsmodel/buttons.dart';
import 'package:music_player/ui/fonts/fonts.dart';
import 'package:music_player/ui/views/Screens/playingsongs.dart';
import 'package:music_player/ui/views/widgets/nullartwork.dart';
import 'package:music_player/ui/views/widgets/playbotton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlayingScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const PlayingScreen({required this.value});

  final List<SongsModel> value;

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  final AppFonts _appFonts = AppFonts();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Buttons>(context).getloop();
  }

  @override
  Widget build(BuildContext context) {
    var height = _appFonts.height(context);

    return Column(
      children: [
        _topbar(context),
        _image(context),
        SizedBox(
          height: height * 0.041,
        ),
        _slider(context),
        SizedBox(
          height: height * 0.068,
        ),
        _isplaying(context),
      ],
    );
  }

  Widget _topbar(BuildContext context) {
    var textfont = _appFonts.textfont(context);
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    return SizedBox(
      height: height * 0.163,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
              )),
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.056),
            child: Text(
              "Now Playing",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: textfont * 0.027),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    var textfont = _appFonts.textfont(context);
    var height = _appFonts.height(context);
    var width = _appFonts.width(context);
    var sizefont = _appFonts.sizefont(context);
    return StreamProvider<SequenceState?>.value(
        value: player.sequenceStateStream,
        initialData: null,
        builder: (context, widegt) {
          return Consumer<SequenceState?>(builder: (context, sequence, child) {
            final index = sequence?.currentIndex;
            return index == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: SizedBox(
                          height: height * 0.341,
                          width: width * 0.75,
                          child: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(20),
                            id: widget.value[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Artworks(
                              height: height * 0.341,
                              width: width * 0.75,
                              size: sizefont * 0.134,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.014,
                      ),
                      Text(
                        widget.value[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(fontSize: textfont * 0.031),
                      ),
                      Text(
                        widget.value[index].subtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(fontSize: textfont * 0.020),
                      )
                    ],
                  );
          });
        });
  }

  Widget _slider(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    var textfont = _appFonts.textfont(context);
    return StreamBuilder<Duration>(
      stream: player.positionStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return Column(
          children: [
            positionData == null
                ? Slider(
                    value: 0.0,
                    onChanged: (value) {},
                    inactiveColor: Colors.grey.shade400,
                    activeColor: Colors.grey,
                  )
                : Slider(
                    value: positionData.inSeconds.toDouble(),
                    min: 0.0,
                    max: player.duration == null
                        ? 1.0
                        : player.duration!.inSeconds.toDouble(),
                    onChanged: (value) {
                      player.seek(Duration(seconds: value.toInt()));
                    },
                    inactiveColor: Colors.grey.shade400,
                    activeColor: Colors.white,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    positionData
                        .toString()
                        .split(".")
                        .first
                        .replaceFirst(RegExp(r"0:"), ""),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: textfont * 0.020),
                  ),
                  Text(
                    player.duration == null
                        ? "00:00"
                        : player.duration
                            .toString()
                            .split(".")
                            .first
                            .replaceFirst(RegExp(r"0:"), ""),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontSize: textfont * 0.020),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _isplaying(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    var height = _appFonts.height(context);
    return SizedBox(
      height: height * 0.110,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _loops(context),
          IconButton(
              onPressed: () {
                Provider.of<Buttons>(context, listen: false).skiptoPrevious();
              },
              icon: const Icon(
                Icons.skip_previous,
                size: 40,
              )),
          StreamBuilder<PlayerState>(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;

                if (playing != true) {
                  return Playbotton(
                    ontap: player.play,
                    icon: Icons.play_arrow,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return Playbotton(
                    ontap: player.pause,
                    icon: Icons.pause,
                  );
                }
                return Playbotton(ontap: player.play, icon: Icons.pause);
              }),
          IconButton(
              onPressed: () {
                Provider.of<Buttons>(context, listen: false).skiptoNext();
              },
              icon: const Icon(
                Icons.skip_next,
                size: 40,
              )),
          _queuelist()
        ],
      ),
    );
  }

  Widget _loops(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    return StreamProvider<LoopMode>.value(
      value: player.loopModeStream,
      initialData: LoopMode.all,
      builder: (context, widget) {
        return Consumer<LoopMode>(
          builder: (context, value, child) => IconButton(
            icon: value != LoopMode.all
                ? const Icon(
                    Icons.repeat_one,
                    size: 25,
                  )
                : const Icon(
                    Icons.repeat,
                    size: 25,
                  ),
            onPressed: () {
              Provider.of<Buttons>(context, listen: false).looped(value);
            },
          ),
        );
      },
    );
  }

  Widget _queuelist() {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              enableDrag: false,
              context: context,
              builder: (context) {
                return PlayingSongs();
              });
        },
        icon: const Icon(
          Icons.playlist_add,
          size: 25,
        ));
  }
}
