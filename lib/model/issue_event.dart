import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey, FieldRename;

import './user.dart' show User;

part 'issue_event.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IssueEvent {
  int id;
  User user;
  DateTime createdAt;
  DateTime updatedAt;
  String authorAssociation;
  String body;
  String bodyHtml;
  @JsonKey(name: "event")
  String type;
  String htmlUrl;

  IssueEvent(
    this.id,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.authorAssociation,
    this.body,
    this.bodyHtml,
    this.type,
    this.htmlUrl,
  );

  factory IssueEvent.fromJson(Map<String, dynamic> json) =>
      _$IssueEventFromJson(json);

  Map<String, dynamic> toJson() => _$IssueEventToJson(this);
}
