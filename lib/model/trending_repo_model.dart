import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, FieldRename;

part 'trending_repo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrendingRepoModel {
  String? fullName;
  String? url;

  String? description;
  String? language;
  String? meta;
  List<String>? contributors;
  String? contributorsUrl;

  String? starCount;
  String? forkCount;
  String? name;

  String? reposName;

  TrendingRepoModel(
    this.fullName,
    this.url,
    this.description,
    this.language,
    this.meta,
    this.contributors,
    this.contributorsUrl,
    this.starCount,
    this.name,
    this.reposName,
    this.forkCount,
  );

  TrendingRepoModel.empty();

  factory TrendingRepoModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingRepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingRepoModelToJson(this);
}
