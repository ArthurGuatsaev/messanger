// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String lastName;
  final Color avatarColor;
  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
  }) : avatarColor = Color.fromRGBO(Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255), 1);

  String get avatarName => '${name.substring(0, 1)}${lastName.substring(0, 1)}';

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
    };
  }

  Map<String, dynamic> toMapForUsers() {
    return <String, dynamic>{
      id: {
        'id': id,
        'name': name,
        'lastName': lastName,
      }
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, name: $name, lastName: $lastName)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.lastName == lastName;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lastName.hashCode;
}
