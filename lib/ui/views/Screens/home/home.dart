import 'package:flutter/material.dart';
import 'package:music_player/core/viewsmodel/themes.dart';
import 'package:music_player/ui/colors/colors.dart';
import 'package:music_player/ui/views/Screens/albums.dart';
import 'package:music_player/ui/views/Screens/artists.dart';

import 'package:music_player/ui/views/Screens/songs.dart';
import 'package:provider/provider.dart';

import '../../../fonts/fonts.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AppFonts _appFonts = AppFonts();
  @override
  Widget build(BuildContext context) {
    var index = Provider.of<Themes>(context).index;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Library"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Provider.of<Themes>(context, listen: false).changeindex();
                  },
                  icon: index
                      ? Icon(
                          Icons.light_mode,
                          color: AppColors.darkgerytab,
                        )
                      : const Icon(Icons.dark_mode))
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                _bottom(context),
              ];
            }),
            body: TabBarView(
              children: [
                Songs(),
                Artists(),
                Album(),
              ],
            ),
          ),
        ));
  }

  Widget _bottom(BuildContext context) {
    var width = _appFonts.width(context);
    return SliverAppBar(
      toolbarHeight: 0,
      pinned: true,
      bottom: TabBar(
          indicatorWeight: 3.5,
          indicatorPadding: EdgeInsets.symmetric(horizontal: width * 0.042),
          tabs: const [
            Tab(text: "Songs"),
            Tab(
              text: "Artists",
            ),
            Tab(
              text: "Albums",
            )
          ]),
    );
  }
}
