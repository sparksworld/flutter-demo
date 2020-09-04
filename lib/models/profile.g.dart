// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..locale = json['locale'] as String
    ..textScaleFactor = (json['textScaleFactor'] as num)?.toDouble()
    ..appTheme = json['appTheme'] == null
        ? null
        : AppTheme.fromJson(json['appTheme'] as Map<String, dynamic>)
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'locale': instance.locale,
      'textScaleFactor': instance.textScaleFactor,
      'appTheme': instance.appTheme,
      'user': instance.user,
    };

AppTheme _$AppThemeFromJson(Map<String, dynamic> json) {
  return AppTheme()..primary = json['primary'] as int;
}

Map<String, dynamic> _$AppThemeToJson(AppTheme instance) => <String, dynamic>{
      'primary': instance.primary,
    };
