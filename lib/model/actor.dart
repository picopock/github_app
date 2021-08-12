import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, FieldRename;

part 'actor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Actor {
  int id;
  String login;
  String displayLogin;
  String gravatarId;
  String url;
  String avatarUrl;

  Actor(
    this.id,
    this.login,
    this.displayLogin,
    this.avatarUrl,
    this.gravatarId,
    this.url,
  );

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  Map<String, dynamic> toJson() => _$ActorToJson(this);
}
