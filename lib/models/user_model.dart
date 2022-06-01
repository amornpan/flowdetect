// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String usertype;
  UserModel({
    required this.email,
    required this.name,
    required this.usertype,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? usertype,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      usertype: usertype ?? this.usertype,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'usertype': usertype,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      usertype: map['usertype'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(email: $email, name: $name, usertype: $usertype)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        other.usertype == usertype;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ usertype.hashCode;
}
