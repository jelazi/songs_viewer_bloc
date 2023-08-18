import 'package:json_annotation/json_annotation.dart';

part 'youtube_video.g.dart';

@JsonSerializable()
class YoutubeVideo {
  String name;
  String path;

  YoutubeVideo({
    required this.name,
    required this.path,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) => _$YoutubeVideoFromJson(json);
  Map<String, dynamic> toJson() => _$YoutubeVideoToJson(this);
}
