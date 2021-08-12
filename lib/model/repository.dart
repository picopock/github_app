import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, FieldRename;

import './user.dart' show User;
import './license.dart' show License;
import './repository_permission.dart' show RepositoryPermission;
part 'repository.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Repository {
  int id;
  String name;
  String url;

  Repository(
    this.id,
    this.name,
    this.url,
  );

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}
