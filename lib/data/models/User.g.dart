// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => new User(
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    dobirth: json['dobirth'] as String,
    password: json['password'] as String);

abstract class _$UserSerializerMixin {
  String get name;

  String get email;

  String get phone;

  String get dobirth;

  String get password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'dobirth': dobirth,
        'password': password
      };
}
