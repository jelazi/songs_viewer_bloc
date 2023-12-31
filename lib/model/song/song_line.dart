import 'package:json_annotation/json_annotation.dart';
import 'package:logger_pkg/logger_pkg.dart';

import 'song_item.dart';
part 'song_line.g.dart';

@JsonSerializable(explicitToJson: true)
class SongLine {
  List<SongItem> listItem = [];
  final int index;
  SongLine(this.index);

  int createItemsFromString(String text, int lastChordItemIndex, bool chords, bool notes) {
    listItem.clear();
    var array = text.split('');
    bool isChord = false;
    bool isNotes = false;
    int index = lastChordItemIndex;
    String subString = '';
    for (var element in array) {
      if (element == '[') {
        if (isChord) {
          logger.e('wrong chord $subString missing ]');
        }
        isChord = true;
        if (subString.isNotEmpty) {
          SongItem item = SongItem(subString, TypeSongItem.lyric);
          listItem.add(item);
          subString = '';
        }
      }
      if (element == '{') {
        if (isNotes) {
          logger.e('wrong note $subString missing }');
        }
        isNotes = true;
        if (subString.isNotEmpty) {
          SongItem item = SongItem(subString, TypeSongItem.lyric);
          listItem.add(item);
          subString = '';
        }
      }
      if (element == ']') {
        if (isChord) {
          SongItem item = SongItem(subString, TypeSongItem.chord);
          item.index = index;
          index++;
          if (chords) {
            listItem.add(item);
          }
          subString = '';
        } else {
          logger.e('wrong chord $subString missing [');
        }
        isChord = false;
      }
      if (element == '}') {
        if (isNotes) {
          SongItem item = SongItem(subString, TypeSongItem.note);
          item.index = index;
          index++;
          if (notes) {
            listItem.add(item);
          }
          subString = '';
        } else {
          logger.e('wrong note $subString missing {');
        }
        isNotes = false;
      }
      if (element != '[' && element != ']' && element != '{' && element != '}') {
        subString += element;
      }
    }
    if (subString.isNotEmpty) {
      if (isChord) {
        logger.e('wrong chord $subString missing ]');
        SongItem item = SongItem(subString, TypeSongItem.chord);
        listItem.add(item);
      } else {
        SongItem item = SongItem(subString, TypeSongItem.lyric);
        listItem.add(item);
      }
    }
    subString = '';
    return index;
  }

  bool isEmpty() {
    if (listItem.isEmpty) return true;
    for (SongItem item in listItem) {
      if (item.text.isNotEmpty) return false;
    }
    return true;
  }

  String songItemsToString({bool withChord = true}) {
    String result = '';
    if (listItem.isEmpty) return result;
    for (SongItem item in listItem) {
      if (item.type == TypeSongItem.chord) {
        if (withChord) {
          result += '[';
          result += item.text;
          result += ']';
        }
      } else {
        result += item.text;
      }
    }
    return result;
  }

  bool isSame(SongLine anotherLine) {
    if (index != anotherLine.index) return false;
    for (var i = 0; i < listItem.length; i++) {
      if (!listItem[i].isSame(anotherLine.listItem[i])) {
        return false;
      }
    }
    return true;
  }

  factory SongLine.fromJson(Map<String, dynamic> json) => _$SongLineFromJson(json);
  Map<String, dynamic> toJson() => _$SongLineToJson(this);
}
