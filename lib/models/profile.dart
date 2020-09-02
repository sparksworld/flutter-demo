import 'package:json_annotation/json_annotation.dart';
import './user.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
      Profile();

  String locale;
  AppTheme appTheme;
  User user;

  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class AppTheme {
      AppTheme();

  int primary;

  factory AppTheme.fromJson(Map<String,dynamic> json) => _$AppThemeFromJson(json);
  Map<String, dynamic> toJson() => _$AppThemeToJson(this);
}
