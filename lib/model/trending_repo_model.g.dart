// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingRepoModel _$TrendingRepoModelFromJson(Map<String, dynamic> json) {
  return TrendingRepoModel(
    json['full_name'] as String?,
    json['url'] as String?,
    json['description'] as String?,
    json['language'] as String?,
    json['meta'] as String?,
    (json['contributors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['contributors_url'] as String?,
    json['star_count'] as String?,
    json['name'] as String?,
    json['repos_name'] as String?,
    json['fork_count'] as String?,
  );
}

Map<String, dynamic> _$TrendingRepoModelToJson(TrendingRepoModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'url': instance.url,
      'description': instance.description,
      'language': instance.language,
      'meta': instance.meta,
      'contributors': instance.contributors,
      'contributors_url': instance.contributorsUrl,
      'star_count': instance.starCount,
      'fork_count': instance.forkCount,
      'name': instance.name,
      'repos_name': instance.reposName,
    };
