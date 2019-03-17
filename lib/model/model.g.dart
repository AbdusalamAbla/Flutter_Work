// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

  LocalMusic _$LocalMusicFromJson(Map<String, dynamic> json) {
  return LocalMusic(
      id: json['id'] as int,
      title: json['title'] as String,
      path: json['path'] as String,
      modify: json['modify'] as String,
      size: json['size'] as String);
}

Map<String, dynamic> _$LocalMusicToJson(LocalMusic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'path': instance.path,
      'modify': instance.modify,
      'size': instance.size
    };
