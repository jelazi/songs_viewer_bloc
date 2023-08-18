// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:default_project/model/youtube_video.dart';
import 'package:default_project/services/enums.dart';
import 'package:json_annotation/json_annotation.dart';

import '../note.dart';



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
}
