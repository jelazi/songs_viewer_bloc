// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongLine _$SongLineFromJson(Map<String, dynamic> json) => SongLine(
      json['index'] as int,
    )..listItem = (json['listItem'] as List<dynamic>)
        .map((e) => SongItem.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$SongLineToJson(SongLine instance) => <String, dynamic>{
      'listItem': instance.listItem.map((e) => e.toJson()).toList(),
      'index': instance.index,
    };
