import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;

import './actor.dart' show Actor;
import './repository.dart' show Repository;

part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String type;
  Actor actor;
  Repository repo;
  Map<String, dynamic> payload;

  @JsonKey(name: 'public')
  bool isPublish;

  @JsonKey(name: "created_at")
  DateTime createdAt;

  Event(
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.payload,
    this.isPublish,
    this.createdAt,
  );

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
