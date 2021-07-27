import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonKey, FieldRename;

import './user.dart' show User;

part 'release_asset.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseAsset {
  int id;
  String name;
  String label;
  User uploader;
  String contentType;
  String state;
  int size;
  int downloadCout;
  DateTime createdAt;
  DateTime updatedAt;
  @JsonKey(name: "browser_download_url")
  String downloadUrl;

  ReleaseAsset(
    this.id,
    this.name,
    this.label,
    this.uploader,
    this.contentType,
    this.state,
    this.size,
    this.downloadCout,
    this.createdAt,
    this.updatedAt,
    this.downloadUrl,
  );

  factory ReleaseAsset.fromJson(Map<String, dynamic> json) =>
      _$ReleaseAssetFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseAssetToJson(this);
}
