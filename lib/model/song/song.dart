// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:default_project/model/youtube_video.dart';
import 'package:default_project/services/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import '../note.dart';
import 'song_item.dart';
import 'song_line.dart';

part 'song.g.dart';

@JsonSerializable(explicitToJson: true)
class Song {
  String id;
  String title;
  String lyrics;
  String? originalLyrics;
  int? indexSongBook;
  String? interpret;
  TypeTranspose typeTranspose = TypeTranspose.czech;

  int? songBar;
  int? bmp;

  List<String>? sheets;
  List<String>? groups;
  List<String>? tags;
  List<Note>? notes;

  List<YoutubeVideo>? youtubeVideos;

  Song({
    required this.id,
    required this.title,
    required this.lyrics,
    this.originalLyrics,
    this.indexSongBook,
    this.interpret,
    this.typeTranspose = TypeTranspose.czech,
    this.songBar,
    this.bmp,
    this.sheets,
    this.groups,
    this.tags,
    this.notes,
    this.youtubeVideos,
  });

  Song copyWith({
    String? id,
    String? title,
    String? lyrics,
    String? originalLyrics,
    int? indexSongBook,
    String? interpret,
    TypeTranspose? typeTranspose,
    int? songBar,
    int? bmp,
    List<String>? sheets,
    List<String>? groups,
    List<String>? tags,
    List<Note>? notes,
    List<YoutubeVideo>? youtubeVideos,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      originalLyrics: originalLyrics ?? this.originalLyrics,
      indexSongBook: indexSongBook ?? this.indexSongBook,
      interpret: interpret ?? this.interpret,
      typeTranspose: typeTranspose ?? this.typeTranspose,
      songBar: songBar ?? this.songBar,
      bmp: bmp ?? this.bmp,
      sheets: sheets ?? this.sheets,
      groups: groups ?? this.groups,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      youtubeVideos: youtubeVideos ?? this.youtubeVideos,
    );
  }

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);

  List<SongLine> listLyrics(bool chords, bool notes, TypeLyric typeLyric) {
    List<SongLine> listLyrics = [];
    List<String> listLines = lyrics.split(('\n'));
    switch (typeLyric) {
      case TypeLyric.undefined:
        listLines = lyrics.split(('\n'));
        listLines += (originalLyrics ?? '').split(('\n'));
        break;
      case TypeLyric.original:
        listLines = (originalLyrics ?? '').split(('\n'));
        break;
      case TypeLyric.translate:
        listLines = lyrics.split(('\n'));
        break;
    }

    int index = 0;
    for (var i = 0; i < listLines.length; i++) {
      SongLine line = SongLine(i);

      index = line.createItemsFromString(listLines[i], index, chords, notes);

      listLyrics.add(line);
    }
    return listLyrics;
  }

  String get lyricsWithoutChords {
    String lyrics = '';
    for (SongLine line in listLyrics(false, true, TypeLyric.translate)) {
      for (SongItem item in line.listItem) {
        if (item.type == TypeSongItem.lyric) {
          lyrics += item.text;
        }
      }
    }
    return lyrics;
  }
}
