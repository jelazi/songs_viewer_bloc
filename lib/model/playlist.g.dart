// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      json['name'] as String,
    )
      ..id = json['id'] as String?
      ..listSongIds = (json['listSongIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'listSongIds': instance.listSongIds,
    };
