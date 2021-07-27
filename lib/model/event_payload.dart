import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, FieldRename;

import './push_event_commit.dart' show PushEventCommit;
import './release.dart' show Release;
import './issue.dart' show Issue;
import './issue_event.dart' show IssueEvent;

part 'event_payload.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventPayload {
  int pushId;
  int size;
  int distinctSize;
  String ref;
  String head;
  String before;
  List<PushEventCommit> commits;
  String action;
  String refType;
  String masterBranch;
  String description;
  String pusherType;
  Release release;
  Issue issue;
  IssueEvent comment;

  EventPayload(
    this.pushId,
    this.size,
    this.distinctSize,
    this.ref,
    this.head,
    this.before,
    this.commits,
    this.action,
    this.refType,
    this.masterBranch,
    this.description,
    this.pusherType,
    this.release,
    this.issue,
    this.comment
  );

  factory EventPayload.fromJson(Map<String, dynamic> json) =>
      _$EventPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$EventPayloadToJson(this);
}
