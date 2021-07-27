// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    json['id'] as String,
    json['type'] as String,
    User.fromJson(json['actor'] as Map<String, dynamic>),
    Repository.fromJson(json['repo'] as Map<String, dynamic>),
    User.fromJson(json['org'] as Map<String, dynamic>),
    EventPayload.fromJson(json['payload'] as Map<String, dynamic>),
    json['public'] as bool,
    DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'org': instance.org,
      'payload': instance.payload,
      'public': instance.isPublish,
      'created_at': instance.createdAt.toIso8601String(),
    };
