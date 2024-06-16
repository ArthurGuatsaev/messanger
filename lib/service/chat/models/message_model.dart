// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'user_model.dart';

class MessageModel {
  final String? text;
  final String? image;
  final DateTime date;
  final UserModel author;
  MessageModel({
    this.text,
    this.image,
    required this.date,
    required this.author,
  });

  MessageModel copyWith({
    String? text,
    String? image,
    DateTime? date,
    UserModel? author,
  }) {
    return MessageModel(
      text: text ?? this.text,
      image: image ?? this.image,
      date: date ?? this.date,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'image': image,
      'date': date.millisecondsSinceEpoch,
      'author': author.toMap(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] != null ? map['text'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      author: UserModel.fromMap(map['author'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(text: $text, image: $image, date: $date, author: $author)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.image == image &&
        other.date == date &&
        other.author == author;
  }

  @override
  int get hashCode {
    return text.hashCode ^ image.hashCode ^ date.hashCode ^ author.hashCode;
  }
}
