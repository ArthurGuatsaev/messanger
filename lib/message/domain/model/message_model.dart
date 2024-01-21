// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel {
  final String message;
  final DateTime date;

  final String name;
  final String? audio;
  const MessageModel(
      {required this.message,
      required this.date,
      this.audio,
      required this.name});

  MessageModel copyWith({
    String? message,
    DateTime? date,
    String? name,
    String? audio,
  }) {
    return MessageModel(
      message: message ?? this.message,
      date: date ?? this.date,
      name: name ?? this.name,
      audio: audio ?? this.audio,
    );
  }

  MessageModel.audio(
      {this.message = '',
      required DateTime d,
      required String nam,
      required String aud})
      : audio = aud,
        name = nam,
        date = d;
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'date': date.millisecondsSinceEpoch,
      'name': name,
      'audio': audio,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      name: map['name'] as String,
      audio: map['audio'] as String?,
    );
  }
}

class ChatModel {
  List<MessageModel> messages;
  ChatModel({
    required this.messages,
  });

  ChatModel copyWith({
    List<MessageModel>? messages,
  }) {
    return ChatModel(
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    final messagesDyn = map['message'] as List<dynamic>;
    final messages = messagesDyn
        .map((e) => MessageModel.fromMap(e as Map<String, dynamic>))
        .toList();
    return ChatModel(messages: messages);
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatModel(messages: $messages)';

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.messages, messages);
  }

  @override
  int get hashCode => messages.hashCode;
}
