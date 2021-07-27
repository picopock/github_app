// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return Release(
    json['id'] as int,
    json['tagName'] as String,
    json['targetCommitish'] as String,
    json['name'] as String,
    json['body'] as String,
    json['bodyHtml'] as String,
    json['tarballUrl'] as String,
    json['zipballUrl'] as String,
    json['draft'] as bool,
    json['prerelease'] as bool,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['publishedAt'] as String),
    User.fromJson(json['author'] as Map<String, dynamic>),
    (json['assets'] as List<dynamic>)
        .map((e) => ReleaseAsset.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'id': instance.id,
      'tagName': instance.tagName,
      'targetCommitish': instance.targetCommitish,
      'name': instance.name,
      'body': instance.body,
      'bodyHtml': instance.bodyHtml,
      'tarballUrl': instance.tarballUrl,
      'zipballUrl': instance.zipballUrl,
      'draft': instance.draft,
      'prerelease': instance.preRelease,
      'createdAt': instance.createdAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
      'author': instance.author,
      'assets': instance.assets,
    };
