import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;

import './user.dart' show User;
import './repository.dart' show Repository;
import './event_payload.dart' show EventPayload;

part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String type;
  User actor;
  Repository repo;
  User org;
  EventPayload payload;

  @JsonKey(name: 'public')
  bool isPublish;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  Event(
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.org,
    this.payload,
    this.isPublish,
    this.createdAt,
  );

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
