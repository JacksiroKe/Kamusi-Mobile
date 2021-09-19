import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends Object with _$UserSerializerMixin {
  String name;
  String email;
  String phone;
  String dobirth;
  String password;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.dobirth,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
