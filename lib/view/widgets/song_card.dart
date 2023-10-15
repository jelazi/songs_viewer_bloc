// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:default_project/view/pages/edit_page.dart';
import 'package:default_project/view/pages/presentation_page.dart';
import 'package:default_project/view/pages/sheet_view_page.dart';
import 'package:default_project/view/pages/youtube_video_page.dart';
import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';

import 'package:default_project/blocs/export_blocs.dart';
import 'package:default_project/view/pages/preview_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../model/song/song.dart';
import '../../services/constants.dart';

class SongCard extends StatefulWidget {
  final Song song;
  final int index;
  final bool isSelectedSong;
  final bool isEditIconVisible;
  final bool isExpanded;

  const SongCard({Key? key, required this.song, required this.index, required this.isSelectedSong, required this.isEditIconVisible, required this.isExpanded}) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    return GestureDetector(
      onTap: () {
        context.read<HomePageBloc>().add(ChangeExpandedCard(songId: widget.song.id));
      },
      child: Container(
          decoration: BoxDecoration(
            color: widget.isSelectedSong ? AppColor.defaultBackgroundColor : Colors.white,
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.song.title,
                  style: h5TextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      widget.song.indexSongBook != null ? '(${widget.song.indexSongBook})' : '',
                      style: labelTextStyle.copyWith(color: AppColor.primaryColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: widget.song.indexSongBook != null ? 10 : 0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.song.interpret ?? '',
                        style: labelTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizeTransition(
                  sizeFactor: _animation,
                  axis: Axis.vertical,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              icon: Icon(
                                MdiIcons.bookMusicOutline,
                                color: AppColor.primaryDarkColor,
                              ),
                              onPressed: () {
                                FLog.debug(text: 'openChords');
                                context.read<PreviewChordBloc>().add(ChangeCurrentSong(song: widget.song));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PreviewPage()),
                                );
                              }),
                          IconButton(
                              icon: Icon(
                                MdiIcons.presentation,
                                color: AppColor.primaryDarkestColor,
                              ),
                              onPressed: () {
                                FLog.debug(text: 'openPresentation');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PresentationPage()),
                                );
                              }),
                          Visibility(
                            visible: widget.song.sheets != null && widget.song.sheets!.isNotEmpty,
                            child: IconButton(
                                icon: Icon(
                                  MdiIcons.imageFrame,
                                  color: AppColor.primaryColor,
                                ),
                                onPressed: () {
                                  FLog.debug(text: 'openSheets');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SheetViewPage()),
                                  );
                                }),
                          ),
                          Visibility(
                            visible: widget.song.youtubeVideos != null,
                            child: IconButton(
                                icon: Icon(
                                  MdiIcons.videoOutline,
                                  color: AppColor.primaryLightColor,
                                ),
                                onPressed: () {
                                  FLog.debug(text: 'openYoutube');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const YoutubeVideoPage()),
                                  );
                                }),
                          ),
                          BlocBuilder<HomePageBloc, HomePageState>(
                            builder: (context, state) {
                              return Visibility(
                                visible: state.isEditIconVisible,
                                child: IconButton(
                                    icon: Icon(
                                      MdiIcons.pencil,
                                      color: AppColor.primaryLightestColor,
                                    ),
                                    onPressed: () {
                                      FLog.debug(text: 'editSong');
                                      context.read<EditSongBloc>().add(ChangeEditSong(song: widget.song));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const EditPage()),
                                      );
                                    }),
                              );
                            },
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            MdiIcons.radioboxMarked,
                            color: widget.isSelectedSong ? Colors.green : AppColor.primaryDarkColor,
                          ),
                          onPressed: () {
                            context.read<HomePageBloc>().add(SelectSong(selectedSongId: widget.song.id));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
