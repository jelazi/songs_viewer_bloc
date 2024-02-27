import 'package:default_project/blocs/export_blocs.dart';
import 'package:flutter/material.dart';
import 'package:logger_pkg/logger_pkg.dart';

import '../../../model/song/song_item.dart';

// ignore: must_be_immutable
class EditSpanDesktop extends StatelessWidget {
  final String char;
  final TextStyle style;
  final int index;
  final Function openChords;
  final Function pasteChords;
  final Function copyChords;
  final TypeSongItem typeSongItem;

  EditSpanDesktop(this.index, this.char, this.typeSongItem, this.openChords, this.copyChords, this.pasteChords, this.style, {Key? key}) : super(key: key);

  Offset? lastPosition;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: typeSongItem == TypeSongItem.chord ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: BlocBuilder<EditSongBloc, EditSongState>(
        builder: (context, state) {
          return Row(
            children: [
              Visibility(
                  visible: state.listSelectedChords.contains(index),
                  child: GestureDetector(
                    onSecondaryTap: () {
                      if (typeSongItem == TypeSongItem.chord) {
                        logger.d('right click');
                      }
                    },
                    onTap: () {
                      if (typeSongItem == TypeSongItem.chord) {
                        context.read<EditSongBloc>().add(ChangePositionChord(index: index, increase: false));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Text(
                          '<',
                          style: style,
                        ),
                      ),
                    ),
                  )),
              GestureDetector(
                /// right click
                onSecondaryTap: () {
                  if (typeSongItem == TypeSongItem.chord) {
                    logger.d('right click');
                  }
                },

                onTap: () {
                  if (typeSongItem == TypeSongItem.chord) {
                    context.read<EditSongBloc>().add(SelectChord(index: index));
                  }
                },
                child: RichText(
                    text: TextSpan(
                  text: char,
                  style: style,
                )),
              ),
              Visibility(
                visible: state.listSelectedChords.contains(index),
                child: GestureDetector(
                  onSecondaryTap: () {
                    if (typeSongItem == TypeSongItem.chord) {
                      logger.d('right click');
                    }
                  },
                  onTap: () {
                    if (typeSongItem == TypeSongItem.chord) {
                      context.read<EditSongBloc>().add(ChangePositionChord(index: index, increase: true));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    width: 30,
                    height: 30,
                    child: Center(
                      child: Text(
                        '>',
                        style: style,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
