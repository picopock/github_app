// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueEvent _$IssueEventFromJson(Map<String, dynamic> json) {
  return IssueEvent(
    json['id'] as int,
    User.fromJson(json['user'] as Map<String, dynamic>),
    DateTime.parse(json['created_at'] as String),
    DateTime.parse(json['updated_at'] as String),
    json['author_association'] as String,
    json['body'] as String,
    json['body_html'] as String,
    json['event'] as String,
    json['html_url'] as String,
  );
}

Map<String, dynamic> _$IssueEventToJson(IssueEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'author_association': instance.authorAssociation,
      'body': instance.body,
      'body_html': instance.bodyHtml,
      'event': instance.type,
      'html_url': instance.htmlUrl,
    };
