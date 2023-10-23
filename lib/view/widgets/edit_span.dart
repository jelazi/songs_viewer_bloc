import 'package:flutter/material.dart';

import '../../model/song/song_item.dart';

class EditSpan extends StatelessWidget {
  String char;
  TextStyle style;
  int index;
  Function openChords;
  Function pasteChords;
  Function copyChords;
  TypeSongItem typeSongItem;
  Offset? lastPosition;
  EditSpan(this.index, this.char, this.typeSongItem, this.openChords, this.copyChords, this.pasteChords, this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: typeSongItem == TypeSongItem.chord ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
          onTap: () {
            if (typeSongItem == TypeSongItem.chord) {
              openChords(index, char, lastPosition, typeSongItem, false);
            }
          },
          onDoubleTap: () {
            if (typeSongItem == TypeSongItem.lyric) {
              pasteChords(index, char, lastPosition, typeSongItem);
            } else {
              copyChords(index, char, lastPosition, typeSongItem);
            }
          },
          onLongPress: () {
            if (typeSongItem == TypeSongItem.lyric) {
              openChords(index, char, lastPosition, typeSongItem, false);
            } else {
              openChords(index, char, lastPosition, typeSongItem, true);
            }
          },
          onTapDown: (details) {
            lastPosition = details.globalPosition;
          },
          child: RichText(
              text: TextSpan(
            text: char,
            style: style,
          ))),
    );
  }
}
