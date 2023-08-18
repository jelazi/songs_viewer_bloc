// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as String,
      title: json['title'] as String,
      lyrics: json['lyrics'] as String,
      originalLyrics: json['originalLyrics'] as String?,
      indexSongBook: json['indexSongBook'] as int?,
      interpret: json['interpret'] as String?,
      typeTranspose:
          $enumDecodeNullable(_$TypeTransposeEnumMap, json['typeTranspose']) ??
              TypeTranspose.czech,
      songBar: json['songBar'] as int?,
      bmp: json['bmp'] as int?,
      sheets:
          (json['sheets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      groups:
          (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
      youtubeVideos: (json['youtubeVideos'] as List<dynamic>?)
          ?.map((e) => YoutubeVideo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lyrics': instance.lyrics,
      'originalLyrics': instance.originalLyrics,
      'indexSongBook': instance.indexSongBook,
      'interpret': instance.interpret,
      'typeTranspose': _$TypeTransposeEnumMap[instance.typeTranspose]!,
      'songBar': instance.songBar,
      'bmp': instance.bmp,
      'sheets': instance.sheets,
      'groups': instance.groups,
      'tags': instance.tags,
      'notes': instance.notes?.map((e) => e.toJson()).toList(),
      'youtubeVideos': instance.youtubeVideos?.map((e) => e.toJson()).toList(),
    };

const _$TypeTransposeEnumMap = {
  TypeTranspose.czech: 'czech',
  TypeTranspose.german: 'german',
};
