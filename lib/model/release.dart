import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey;

import './release_asset.dart' show ReleaseAsset;
import './user.dart' show User;

part 'release.g.dart';

@JsonSerializable()
class Release {
  int id;
  String tagName;
  String targetCommitish;
  String name;
  String body;
  String bodyHtml;
  String tarballUrl;
  String zipballUrl;

  bool draft;
  @JsonKey(name: "prerelease")
  bool preRelease;
  DateTime createdAt;
  DateTime publishedAt;

  User author;
  List<ReleaseAsset> assets;

  Release(
    this.id,
    this.tagName,
    @JsonKey(name: "target_commitish") this.targetCommitish,
    this.name,
    this.body,
    this.bodyHtml,
    this.tarballUrl,
    this.zipballUrl,
    this.draft,
    this.preRelease,
    this.createdAt,
    this.publishedAt,
    this.author,
    this.assets,
  );

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}
