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

  const SongCard({Key? key, required this.song, required this.index, required this.isSelectedSong, required this.isEditIconVisible}) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
            color: widget.isSelectedSong ? AppColor.defaultBackgroundColor : Colors.white,
            border: Border.all(color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(4),
          ),
          margin: const EdgeInsets.all(4),
          width: MediaQuery.of(context).size.width,
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            title: Text(
              widget.song.title,
              style: h5TextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
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
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 15.0),
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
                        IconButton(
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
                        IconButton(
                            icon: Icon(
                              MdiIcons.pencil,
                              color: AppColor.primaryLightestColor,
                            ),
                            onPressed: () {
                              FLog.debug(text: 'editSong');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditPage()),
                              );
                            }),
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
              )
            ],
          )),
    );
  }
}
