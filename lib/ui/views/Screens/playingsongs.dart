import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:music_player/core/viewsmodel/buttons.dart';
import 'package:music_player/ui/colors/colors.dart';
import 'package:music_player/ui/fonts/fonts.dart';

class PlayingSongs extends StatelessWidget {
  PlayingSongs({Key? key}) : super(key: key);

  final AppFonts _appFonts = AppFonts();

  final ScrollController controller = ScrollController();

  void playerindex(int scollheight, double height) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => controller.jumpTo(
          0.067 * height * scollheight,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var height = _appFonts.height(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        queue(context),
        Divider(
          height: height * 0.0068,
        ),
        playlist(context)
      ],
    );
  }

  Widget queue(BuildContext context) {
    var height = _appFonts.height(context);
    var value = Provider.of<Buttons>(context).val;
    var textfont = _appFonts.textfont(context);
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        height: height * 0.054,
        width: double.maxFinite,
        child: Text(
          "Queue (${value.length} songs)",
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: textfont * 0.024,
              ),
        ));
  }

  Widget playlist(BuildContext context) {
    var player = Provider.of<Buttons>(context).player;
    var textfont = _appFonts.textfont(context);
    var value = Provider.of<Buttons>(context).val;
    var height = _appFonts.height(context);
    return StreamProvider<SequenceState?>.value(
        value: player.sequenceStateStream,
        initialData: null,
        builder: (context, widegt) {
          return Consumer<SequenceState?>(builder: (context, sequence, child) {
            final currentindex = sequence?.currentIndex;
            var scollheight = currentindex ?? 0;
            playerindex(scollheight, height);
            return Expanded(
              child: ListView.separated(
                controller: controller,
                padding: const EdgeInsets.only(left: 10),
                separatorBuilder: (context, index) {
                  return Divider(
                    height: height * 0.0068,
                  );
                },
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Provider.of<Buttons>(context, listen: false)
                            .playlist(value, index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        height: height * 0.061,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                value[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        fontSize: textfont * 0.020,
                                        color: currentindex == index
                                            ? AppColors.blueaccent
                                            : Theme.of(context).indicatorColor),
                              ),
                            ),
                            Text("-",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                            Flexible(
                              child: Text(value[index].subtitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontSize: textfont * 0.018,
                                          color: currentindex == index
                                              ? AppColors.blueaccent
                                              : Theme.of(context)
                                                  .indicatorColor)),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            );
          });
        });
  }
}
