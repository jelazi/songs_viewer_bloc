import 'package:json_annotation/json_annotation.dart';

part 'song_item.g.dart';

@JsonSerializable()
class SongItem {
  String text = '';
  TypeSongItem type;
  int index = 0;

  SongItem(this.text, this.type);

  factory SongItem.fromJson(Map<String, dynamic> json) => _$SongItemFromJson(json);
  Map<String, dynamic> toJson() => _$SongItemToJson(this);

  bool isSame(SongItem anotherItem) {
    return (type == anotherItem.type && index == anotherItem.index && text == anotherItem.text);
  }
}

enum TypeSongItem {
  chord,
  lyric,
  note,
}
