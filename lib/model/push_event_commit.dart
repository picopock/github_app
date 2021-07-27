import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

import './user.dart' show User;

part 'push_event_commit.g.dart';

@JsonSerializable()
class PushEventCommit {
  String sha;
  User author;
  String message;
  bool distinct;
  String url;

  PushEventCommit(
    this.sha,
    this.author,
    this.message,
    this.distinct,
    this.url,
  );

  factory PushEventCommit.fromJson(Map<String, dynamic> json) =>
      _$PushEventCommitFromJson(json);

  Map<String, dynamic> toJson() => _$PushEventCommitToJson(this);
}
