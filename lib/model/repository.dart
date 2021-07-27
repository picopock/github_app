import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, FieldRename;

import './user.dart' show User;
import './license.dart' show License;
import './repository_permission.dart' show RepositoryPermission;
part 'repository.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Repository {
  int id;
  int size;
  String name;
  String fullName;
  String htmlUrl;
  String description;
  String language;
  String defaultBranch;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime pushedAt;
  String gitUrl;
  String sshUrl;
  String cloneUrl;
  String svnUrl;
  int stargazersCount;
  int watchersCount;
  int forksCount;
  int openIssuesCount;
  int subscribersCount;
  bool private;
  bool fork;
  bool hasIssues;
  bool hasProjects;
  bool hasDownloads;
  bool hasWiki;
  bool hasPages;
  User owner;
  License license;
  Repository parent;
  RepositoryPermission permissions;
  List<String> topics;

  ///issue总数，不参加序列化
  late int allIssueCount;

  Repository(
    this.id,
    this.size,
    this.name,
    this.fullName,
    this.htmlUrl,
    this.description,
    this.language,
    this.defaultBranch,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.stargazersCount,
    this.watchersCount,
    this.forksCount,
    this.openIssuesCount,
    this.subscribersCount,
    this.private,
    this.fork,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.owner,
    this.license,
    this.parent,
    this.permissions,
    this.topics,
  );

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
