// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryPermission _$RepositoryPermissionFromJson(Map<String, dynamic> json) {
  return RepositoryPermission(
    json['admin'] as bool,
    json['push'] as bool,
    json['pull'] as bool,
  );
}

Map<String, dynamic> _$RepositoryPermissionToJson(
        RepositoryPermission instance) =>
    <String, dynamic>{
      'admin': instance.admin,
      'push': instance.push,
      'pull': instance.pull,
    };
