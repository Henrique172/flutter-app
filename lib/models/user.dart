import 'dart:convert';

class User {
  final id;
  final  name;
  final  email;
  final  avatarUrl;

  User({
     this.id,
    required this.name,
    required this.email,
     this.avatarUrl,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}
