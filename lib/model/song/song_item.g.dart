// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongItem _$SongItemFromJson(Map<String, dynamic> json) => SongItem(
      json['text'] as String,
      $enumDecode(_$TypeSongItemEnumMap, json['type']),
    )..index = json['index'] as int;

Map<String, dynamic> _$SongItemToJson(SongItem instance) => <String, dynamic>{
      'text': instance.text,
      'type': _$TypeSongItemEnumMap[instance.type]!,
      'index': instance.index,
    };

const _$TypeSongItemEnumMap = {
  TypeSongItem.chord: 'chord',
  TypeSongItem.lyric: 'lyric',
  TypeSongItem.note: 'note',
};
