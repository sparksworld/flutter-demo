// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..gender = json['gender'] as String
    ..age = json['age'] as String
    ..token = json['token'] as String
    ..permissions = json['permissions'] == null
        ? null
        : Permissions.fromJson(json['permissions'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'gender': instance.gender,
      'age': instance.age,
      'token': instance.token,
      'permissions': instance.permissions,
    };

Permissions _$PermissionsFromJson(Map<String, dynamic> json) {
  return Permissions();
}

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{};
